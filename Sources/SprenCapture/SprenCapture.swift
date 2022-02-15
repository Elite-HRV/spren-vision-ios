//
//  SprenCapture.swift
//  
//
//  Created by nick on 16.12.2021.
//

import Foundation
import AVFoundation
import SprenVision

open class SprenCapture {
    
    public let session = AVCaptureSession()
    
    private let videoDevice: AVCaptureDevice
    private let videoOutput = AVCaptureVideoDataOutput()
    private let sprenCaptureDelegate = SprenCaptureDelegate()
    
    // state for config adjustments
    private var formats: [AVCaptureDevice.Format]
    
    private var formatIndex: Int
    private var frameRate: Int
    private var resolution: Int
    
    // camera config
    static private let frameRate: (min: Double, max: Double) = (min: 60, max: 120)
    static private let resolution = (min: 1280*720, max: 1920*1080)
    private let filter: (AVCaptureDevice.Format) -> Bool = { format in
        let cond1 = format.resolution >= resolution.min && format.resolution <= resolution.max
        let cond2 = format.videoSupportedFrameRateRanges.contains { $0.maxFrameRate >= frameRate.min && $0.maxFrameRate <= frameRate.max }
        
        let cond3 = !format.supportedColorSpaces.contains(.P3_D65)
        let cond4 = !format.isVideoHDRSupported
        
        return cond1 && cond2 && cond3 && cond4
    }

    let videoOrientation: AVCaptureVideoOrientation = .portrait
    
    
    public init() throws {
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            throw SprenCaptureError.noCameraDetected
        }
        self.videoDevice = videoDevice
        
        formats = videoDevice.formats.filter(filter)
        guard !formats.isEmpty else {
            throw SprenCaptureError.noCameraFormatDetected
        }
        
        formats.sort { format1, format2 in
            format1.videoSupportedFrameRateRanges[0].maxFrameRate < format2.videoSupportedFrameRateRanges[0].maxFrameRate
        }
                
        formatIndex = formats.count - 1
        frameRate  = Int(formats[formatIndex].frameRate)
        resolution = formats[formatIndex].resolution
                
        try configureDevice()
        try configureSession()
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
        session.startRunning()
    }

    public func stop() {
        session.stopRunning()
    }
    
    public func setTorchMode(to newMode: AVCaptureDevice.TorchMode) throws -> AVCaptureDevice.TorchMode {
        try videoDevice.lockForConfiguration()
        if newMode == .off {
            videoDevice.torchMode = .off
        } else {
            try videoDevice.setTorchModeOn(level: 1.0)
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
