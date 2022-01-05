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
    
    private let videoDevice: AVCaptureDevice? = .default(.builtInWideAngleCamera, for: .video, position: .back)
    private let videoOutput = AVCaptureVideoDataOutput()
    private let sprenCaptureDelegate = SprenCaptureDelegate()
    
    public init() throws {
        try configure()
    }
    
    public func start() {
        session.startRunning()
    }

    public func stop() {
        session.stopRunning()
    }
    
    public func toggleTorch() throws -> AVCaptureDevice.TorchMode {
        guard let device = self.videoDevice else {
            throw SprenCaptureError.noCameraDetected
        }
        
        try device.lockForConfiguration()
        if device.torchMode == .on {
            device.torchMode = .off
        } else {
            try device.setTorchModeOn(level: 1.0)
        }
        device.unlockForConfiguration()
        
        return device.torchMode
    }
    
    private func configure() throws {
        guard let videoDevice = self.videoDevice else {
            throw SprenCaptureError.noCameraDetected
        }
        try configure(videoDevice: videoDevice)
        try configureSession(with: videoDevice)
        configure(videoOutput: videoOutput)
    }
    
    private func configure(videoDevice device: AVCaptureDevice) throws {
        guard let format = device.formats.first(where: CameraConfig.filter) else {
            throw SprenCaptureError.noCameraFormatDetected
        }
        try device.lockForConfiguration()
        device.activeFormat = format
        device.activeVideoMinFrameDuration = CMTime(value: 1, timescale: Int32(CameraConfig.frameRate))
//        configureVideoDeviceAutoFeatures(with: device)
//        let poi = CGPoint(x: 0.5, y: 0.5)
//        device.focusPointOfInterest = poi
//        device.exposurePointOfInterest = poi
        device.unlockForConfiguration()
    }
    
    private func configureSession(with videoDevice: AVCaptureDevice) throws {
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
        session.startRunning()
    }
    
    private func configure(videoOutput output: AVCaptureVideoDataOutput) {
        if let connection = output.connection(with: .video) {
            connection.videoOrientation = CameraConfig.videoOrientation
        }
        videoOutput.setSampleBufferDelegate(sprenCaptureDelegate, queue: .global(qos: .userInitiated))
        videoOutput.videoSettings = [String(kCVPixelBufferPixelFormatTypeKey): kCVPixelFormatType_32BGRA]
    }
    
//    private func configureVideoDeviceAutoFeatures(with device: AVCaptureDevice) {
//        if device.isWhiteBalanceModeSupported(.autoWhiteBalance) {
//            device.whiteBalanceMode = AVCaptureDevice.WhiteBalanceMode.autoWhiteBalance
//        } else if device.isWhiteBalanceModeSupported(.locked) {
//            device.whiteBalanceMode = AVCaptureDevice.WhiteBalanceMode.locked
//        }
//
//        if device.isFocusModeSupported(.autoFocus) {
//            device.focusMode = AVCaptureDevice.FocusMode.autoFocus
//        } else if device.isFocusModeSupported(.locked) {
//            device.focusMode = AVCaptureDevice.FocusMode.locked
//        }
//
//        if device.isExposureModeSupported(.autoExpose) {
//            device.exposureMode = AVCaptureDevice.ExposureMode.autoExpose
//        } else if device.isExposureModeSupported(.locked) {
//            device.exposureMode = AVCaptureDevice.ExposureMode.locked
//        }
//    }
}
