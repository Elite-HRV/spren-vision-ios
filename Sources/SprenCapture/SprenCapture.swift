//
//  SprenCapture.swift
//  
//
//  Created by nick on 16.12.2021.
//

import Foundation
import AVFoundation
import DeviceKit
import SprenCore

open class SprenCapture {
    
    public let session = AVCaptureSession()

    static public var flutter = false

    private let videoDevice: AVCaptureDevice
    private let videoOutput = AVCaptureVideoDataOutput()
    private let sprenCaptureDelegate = SprenCaptureDelegate()
    
    // state for config adjustments
    private var formats: [AVCaptureDevice.Format]
    
    private var formatIndex: Int
    private var resolution: Int
    private var frameRate: Int

    // camera config
    static private let minFrameRate = 60
    static private let minResolution = 1280*720

    static private let (maxFrameRate, maxResolution): (Int, Int) = {
        if flutter {
            return (60, 1280*720)
        }

        switch Device.current {
        case .iPhone6s:     return (100, 1280*720)
        case .iPhone6sPlus: return (100, 1280*720)
        case .iPhone7:      return (100, 1280*720)
        case .iPhone7Plus:  return (100, 1280*720)
        
        case .iPhoneSE:     return (120, 1280*720)
        case .iPhone8:      return (120, 1280*720)
        case .iPhone8Plus:  return (120, 1280*720)
        case .iPhoneX:      return (120, 1280*720)
        case .iPhoneXR:     return (120, 1280*720)
        case .iPhoneXS:     return (120, 1280*720)
        case .iPhoneXSMax:  return (120, 1280*720)
        
        case .iPhoneSE2:    return (120, 1920*1080)
        default: return (120, 1920*1080)
        }
    }()

    private let filter: (AVCaptureDevice.Format) -> Bool = { format in
        let cond1 = format.resolution >= minResolution && format.resolution <= maxResolution
        let cond2 = !format.hrsiSupported

        let cond3 = format.videoSupportedFrameRateRanges.contains { maxFrameRate <= Int($0.maxFrameRate) }

        let cond4 = format.formatDescription.mediaSubType == .init(rawValue: kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange)
        let cond5 = !format.supportedColorSpaces.contains(.P3_D65)
        let cond6 = !format.isVideoHDRSupported

        return cond1 && cond2 && cond3 && cond4 && cond5 && cond6
    }

    let videoOrientation: AVCaptureVideoOrientation = .portrait
    
    
    public init() throws {
        let deviceType: AVCaptureDevice.DeviceType
        switch Device.current {
        case .iPhone7Plus, .iPhone8Plus:
            deviceType = .builtInTelephotoCamera
        default:
            deviceType = .builtInWideAngleCamera
        }
        guard let videoDevice = AVCaptureDevice.default(deviceType, for: .video, position: .back) else {
            throw SprenCaptureError.noCameraDetected
        }
        self.videoDevice = videoDevice
        
        formats = videoDevice.formats.filter(filter)
        guard !formats.isEmpty else {
            throw SprenCaptureError.noCameraFormatDetected
        }
        
        formats.sort { format1, format2 in
            format1.frameRate < format2.frameRate
        }
                
        formatIndex = formats.count - 1
        frameRate  = min(Self.maxFrameRate, formats[formatIndex].frameRate)
        resolution = formats[formatIndex].resolution
                
        try configureSession()
        try configureDevice()
        try configureOutput()
    }
    
    private func configureDevice() throws {
        guard let format = formats.last else {
            throw SprenCaptureError.noCameraFormatDetected
        }
        
        try videoDevice.lockForConfiguration()
        videoDevice.activeFormat = format
        let frameDuration = CMTime(value: 1, timescale: CMTimeScale(frameRate))
        videoDevice.activeVideoMinFrameDuration = frameDuration
        videoDevice.activeVideoMaxFrameDuration = frameDuration
        videoDevice.unlockForConfiguration()
    }
    
    private func configureSession() throws {
        guard let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            throw SprenCaptureError.deviceInputConfigurationError
        }
        if !session.canAddInput(videoInput) || !session.canAddOutput(videoOutput) {
            throw SprenCaptureError.sessionInputOutputConfigurationError
        }
        
        session.beginConfiguration()
        session.sessionPreset = .inputPriority
        session.addInput(videoInput)
        session.addOutput(videoOutput)
        session.commitConfiguration()
    }
    
    private func configureOutput() throws {
        guard let connection = videoOutput.connection(with: .video) else {
            throw SprenCaptureError.sessionInputOutputConfigurationError
        }
        connection.videoOrientation = videoOrientation
        videoOutput.setSampleBufferDelegate(sprenCaptureDelegate, queue: .global(qos: .userInitiated))
        videoOutput.videoSettings = [String(kCVPixelBufferPixelFormatTypeKey): kCVPixelFormatType_32BGRA]
    }
    
}

// MARK: - public API

extension SprenCapture {
    
    public func start() {
        self.session.startRunning()
    }

    public func stop() {
        self.session.stopRunning()
    }
    
    public func setTorchMode(to newMode: AVCaptureDevice.TorchMode) throws -> AVCaptureDevice.TorchMode {
        guard videoDevice.hasTorch && videoDevice.isTorchAvailable else { return videoDevice.torchMode }
        try videoDevice.lockForConfiguration()
        if newMode == .off {
            videoDevice.torchMode = .off
        } else {
            try videoDevice.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
        }
        videoDevice.unlockForConfiguration()
        return videoDevice.torchMode
    }
    
    public func lock() throws {
        try videoDevice.lockForConfiguration()
        videoDevice.whiteBalanceMode = .locked
        videoDevice.focusMode        = .locked
        videoDevice.exposureMode     = .locked
        videoDevice.unlockForConfiguration()
    }
    
    public func unlock() throws {
        try videoDevice.lockForConfiguration()
        videoDevice.whiteBalanceMode = .continuousAutoWhiteBalance
        videoDevice.focusMode        = .continuousAutoFocus
        videoDevice.exposureMode     = .continuousAutoExposure
        videoDevice.unlockForConfiguration()
    }
    
    private func dropFrameRate() throws -> Bool {
        if frameRate == 120 {
            frameRate = 60
            try configureDevice()
            return true
        } else {
            return false
        }
    }
        
    private func dropResolution() throws -> Bool {
        let lowerResFormats = formats.filter { format in
            return format.resolution < formats[formatIndex].resolution
        }
        
        guard lowerResFormats.count > 0 else { return false }
        
        formats = lowerResFormats
        formatIndex = formats.count - 1
        frameRate  = Int(formats[formatIndex].frameRate)
        frameRate  = min(Self.maxFrameRate, formats[formatIndex].frameRate)
        resolution = formats[formatIndex].resolution
        try configureDevice()
        return true
    }
        
    public func dropComplexity() throws -> Bool {
        print("dropping complexity - \(frameRate)fps, \(resolution)px")
        
        if try dropResolution() {
            print("dropped resolution - \(frameRate)fps, \(resolution)px")
            return true
        }
        
        if try dropFrameRate() {
            print("dropped framerate - \(frameRate)fps, \(resolution)px")
            return true
        }
        
        return false
    }
    
}
