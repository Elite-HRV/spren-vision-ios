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
    private var formats: [AVCaptureDevice.Format]
    private var formatIndex: Int
    
    static private let frameRate: (min: Double, max: Double) = (min: 60, max: 240)
    static private let resolution = (min: 1280*720, max: 1920*1080)
    private let filter: (AVCaptureDevice.Format) -> Bool = { format in
        let cond1 = format.resolution >= resolution.min && format.resolution <= resolution.max
        let cond2 = format.videoSupportedFrameRateRanges.contains { $0.maxFrameRate >= frameRate.min && $0.maxFrameRate <= frameRate.max }
        
        let cond3 = !format.supportedColorSpaces.contains(.P3_D65)
        let cond4 = !format.isVideoHDRSupported
        
        return cond1 && cond2 && cond3 && cond4
    }

    let videoOrientation: AVCaptureVideoOrientation = .portrait
    
    private let videoOutput = AVCaptureVideoDataOutput()
    private let sprenCaptureDelegate = SprenCaptureDelegate()
    
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
        videoDevice.activeVideoMinFrameDuration = CMTime(value: 1, timescale: CMTimeScale(format.frameRate))
//        let poi = CGPoint(x: 0.5, y: 0.5)
//        device.focusPointOfInterest = poi
//        device.exposurePointOfInterest = poi
        videoDevice.unlockForConfiguration()
        
        try unlock()
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
    
    public func toggleTorch() throws -> AVCaptureDevice.TorchMode {
        try videoDevice.lockForConfiguration()
        if videoDevice.torchMode == .on {
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
    
    public func dropFrameRate() throws -> Bool {
        guard formatIndex > 0 else { return false }
        
        var testIndex = formatIndex - 1
        while testIndex >= 0 {
            if formats[testIndex].frameRate < formats[formatIndex].frameRate {
                formatIndex = testIndex
                try configureDevice()
                return true
            }
            testIndex -= 1
        }
        return false
    }
    
    public func increaseFrameRate() throws -> Bool {
        guard formatIndex < formats.count - 1 else { return false }
        
        var testIndex = formatIndex + 1
        while testIndex <= formats.count - 1 {
            if formats[testIndex].frameRate < formats[formatIndex].frameRate {
                formatIndex = testIndex
                try configureDevice()
                return true
            }
            testIndex += 1
        }
        return false
    }
    
    public func dropResolution() throws -> Bool {
        guard formatIndex > 0 else { return false }
        
        var testIndex = formatIndex - 1
        while testIndex >= 0 {
            if formats[testIndex].resolution < formats[formatIndex].resolution {
                formatIndex = testIndex
                try configureDevice()
                return true
            }
            testIndex -= 1
        }
        return false
    }
    
    public func increaseResolution() throws -> Bool {
        guard formatIndex < formats.count - 1 else { return false }
        
        var testIndex = formatIndex + 1
        while testIndex <= formats.count - 1 {
            if formats[testIndex].resolution < formats[formatIndex].resolution {
                formatIndex = testIndex
                try configureDevice()
                return true
            }
            testIndex += 1
        }
        return false
    }
    
    public func dropComplexity() throws -> Bool {
        if try !dropFrameRate() {
            return try dropResolution()
        } else {
            return true
        }
    }
    
}
