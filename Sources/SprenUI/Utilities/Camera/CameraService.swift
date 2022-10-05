//
//  CameraService.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 02/08/22.
//

import Foundation
//import Combine
import AVFoundation
//import Photos
//import UIKit
import SwiftUI
import VideoToolbox
import CoreVideo
import Vision

enum SessionSetupResult {
    case success
    case notAuthorized
    case configurationFailed
}

//  Class Camera Service, handles setup of AVFoundation needed for a basic camera app.
public struct Photo: Identifiable, Equatable {
//    The ID of the captured photo
    public var id: String
//    Data representation of the captured photo
    public var originalData: Data
    
    public var image: UIImage?
    
    public init(id: String = UUID().uuidString, originalData: Data) {
        self.id = id
        self.originalData = originalData
        self.image = UIImage(data:originalData,scale:1.0)
    }
}

//extension Photo {
//    public var compressedData: Data? {
//        ImageResizer(targetWidth: 800).resize(data: originalData)?.jpegData(compressionQuality: 0.5)
//    }
//    public var thumbnailData: Data? {
//        ImageResizer(targetWidth: 100).resize(data: originalData)?.jpegData(compressionQuality: 0.5)
//    }
//    public var thumbnailImage: UIImage? {
//        guard let data = thumbnailData else { return nil }
//        return UIImage(data: data)
//    }
//    public var image: UIImage? {
//        guard let data = compressedData else { return nil }
//        return UIImage(data: data)
//    }
//}

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}

public class CameraService: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate{
    private var currentFrame: CGImage?
    private var currentFrameImage: UIImage?
    
    var setupResult: SessionSetupResult = .success
    var isConfigured = false
    var isSessionRunning = false
    
    public let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "session queue")
    private let photoOutput = AVCapturePhotoOutput()
    private let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInDualCamera, .builtInTrueDepthCamera], mediaType: .video, position: .unspecified)
    
    @objc dynamic var videoDeviceInput: AVCaptureDeviceInput!
    @objc dynamic var videoDevice: AVCaptureDevice!
    
    // Observed Properties UI must react to
    @Published public var isCameraButtonDisabled = true
    @Published public var isCameraUnavailable = true
    @Published public var flashMode: AVCaptureDevice.FlashMode = .off
    @Published public var willCapturePhoto = false
    @Published public var photo: Photo?
    @Published public var shouldShowSpinner = false
    @Published public var time: Int?
    @Published public var timerTime: Int?
    @Published public var image: UIImage?
    @Published public var bodyPoints: [CGPoint]?
    
    private var inProgressPhotoCaptureDelegates = [Int64: PhotoCaptureProcessor]()
    private var currentTimer: Timer?
    private var visionTimer: TimeInterval = 0
    private var lastScale: CGFloat?
    
    fileprivate var videoDataOutput = AVCaptureVideoDataOutput()

    public func configure() {
        sessionQueue.async {
            self.configureSession()
        }
    }
    
    private func configureSession() {
        if setupResult != .success {
            return
        }
        
        session.beginConfiguration()
        
        session.sessionPreset = .photo
        
        // Add video input.
        do {
            var defaultVideoDevice: AVCaptureDevice?
            
            if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
                // If a rear dual camera is not available, default to the rear wide angle camera.
                defaultVideoDevice = backCameraDevice
            } else if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                // If the rear wide angle camera isn't available, default to the front wide angle camera.
                defaultVideoDevice = frontCameraDevice
            }
            
            guard let videoDevice = defaultVideoDevice else {
                print("Default video device is unavailable.")
                setupResult = .configurationFailed
                session.commitConfiguration()
                return
            }
            
            self.videoDevice = videoDevice
            
            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
                
            } else {
                print("Couldn't add video device input to the session.")
                setupResult = .configurationFailed
                session.commitConfiguration()
                return
            }
        } catch {
            print("Couldn't create video device input: \(error)")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        
        let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQueue")
        videoDataOutput.setSampleBufferDelegate(self, queue:videoDataOutputQueue)
        
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
        }
        
        // Add the photo output.
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
            
            photoOutput.isHighResolutionCaptureEnabled = true
            photoOutput.maxPhotoQualityPrioritization = .quality

        } else {
            print("Could not add photo output to the session")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        
        session.commitConfiguration()

        self.isConfigured = true
        
        self.start()
    }
    
    public func start() {
    //        We use our capture session queue to ensure our UI runs smoothly on the main thread.
        sessionQueue.async {
            if !self.isSessionRunning && self.isConfigured {
                switch self.setupResult {
                case .success:
                    self.session.startRunning()
                    self.isSessionRunning = self.session.isRunning
                    
                    if self.session.isRunning {
                        DispatchQueue.main.async {
                            self.isCameraButtonDisabled = false
                            self.isCameraUnavailable = false
                        }
                    }
                    
                case .configurationFailed, .notAuthorized:
                    print("Application not authorized to use camera")

                    DispatchQueue.main.async {
                        print("ERROR: Camera configuration failed.")
//                        self.alertError = AlertError(title: "Camera Error", message: "Camera configuration failed. Either your device camera is not available or its missing permissions", primaryButtonTitle: "Accept", secondaryButtonTitle: nil, primaryAction: nil, secondaryAction: nil)
//                        self.shouldShowAlertView = true
                        self.isCameraButtonDisabled = true
                        self.isCameraUnavailable = true
                    }
                }
            }
        }
    }
    
    public func isCameraFlipped() -> Bool {
        return self.videoDeviceInput.device.position == .back
    }
    
    public func changeCamera() {
        DispatchQueue.main.async {
            self.isCameraButtonDisabled = true
        }
                    
        sessionQueue.async {
            let currentVideoDevice = self.videoDeviceInput.device
            let currentPosition = currentVideoDevice.position
            
            let preferredPosition: AVCaptureDevice.Position
            let preferredDeviceType: AVCaptureDevice.DeviceType
            
            switch currentPosition {
            case .unspecified, .front:
                preferredPosition = .back
                preferredDeviceType = .builtInWideAngleCamera
                
            case .back:
                preferredPosition = .front
                preferredDeviceType = .builtInWideAngleCamera
                
            @unknown default:
                print("Unknown capture position. Defaulting to back, dual-camera.")
                preferredPosition = .back
                preferredDeviceType = .builtInWideAngleCamera
            }
            let devices = self.videoDeviceDiscoverySession.devices
            var newVideoDevice: AVCaptureDevice? = nil
            
            // First, seek a device with both the preferred position and device type. Otherwise, seek a device with only the preferred position.
            if let device = devices.first(where: { $0.position == preferredPosition && $0.deviceType == preferredDeviceType }) {
                newVideoDevice = device
            } else if let device = devices.first(where: { $0.position == preferredPosition }) {
                newVideoDevice = device
            }
            
            if let videoDevice = newVideoDevice {
                do {
                    let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
                    
                    self.session.beginConfiguration()
                    
                    // Remove the existing device input first, because AVCaptureSession doesn't support
                    // simultaneous use of the rear and front cameras.
                    self.session.removeInput(self.videoDeviceInput)
                    
                    if self.session.canAddInput(videoDeviceInput) {
                        self.session.addInput(videoDeviceInput)
                        self.videoDeviceInput = videoDeviceInput
                    } else {
                        self.session.addInput(self.videoDeviceInput)
                    }
                    
                    if let connection = self.photoOutput.connection(with: .video) {
                        if connection.isVideoStabilizationSupported {
                            connection.preferredVideoStabilizationMode = .auto
                        }
                    }
                    
                    self.photoOutput.maxPhotoQualityPrioritization = .quality
                    
                    self.session.commitConfiguration()
                } catch {
                    print("Error occurred while creating video device input: \(error)")
                }
            }

            self.videoDevice = newVideoDevice

            DispatchQueue.main.async {
                self.isCameraButtonDisabled = false
            }
        }
    }
    
    public func capturePhoto() {
        if self.setupResult != .configurationFailed {
            self.isCameraButtonDisabled = true
            
            sessionQueue.async {
                if let photoOutputConnection = self.photoOutput.connection(with: .video) {
                    photoOutputConnection.videoOrientation = .portrait
                }
                var photoSettings = AVCapturePhotoSettings()
                
                // Capture HEIF photos when supported. Enable according to user settings and high-resolution photos.
                if  self.photoOutput.availablePhotoCodecTypes.contains(.hevc) {
                    photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
                }
                
                // Sets the flash option for this capture.
                if self.videoDeviceInput.device.isFlashAvailable {
                    photoSettings.flashMode = self.flashMode
                }
                
                photoSettings.isHighResolutionPhotoEnabled = true
                
                // Sets the preview thumbnail pixel format
                if !photoSettings.__availablePreviewPhotoPixelFormatTypes.isEmpty {
                    photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoSettings.__availablePreviewPhotoPixelFormatTypes.first!]
                }
                
                photoSettings.photoQualityPrioritization = .quality
                
                let photoCaptureProcessor = PhotoCaptureProcessor(with: photoSettings, willCapturePhotoAnimation: { [weak self] in
                    // Tells the UI to flash the screen to signal that SwiftCamera took a photo.
                    DispatchQueue.main.async {
                        self?.willCapturePhoto = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self?.willCapturePhoto = false
                    }
                    
                }, completionHandler: { [weak self] (photoCaptureProcessor) in
                    // When the capture is complete, remove a reference to the photo capture delegate so it can be deallocated.
                    if let data = photoCaptureProcessor.photoData {
                        self?.photo = Photo(originalData: data)
                        print("passing photo")
                    } else {
                        print("No photo data")
                    }
                    
                    self?.isCameraButtonDisabled = false
                    
                    self?.sessionQueue.async {
                        self?.inProgressPhotoCaptureDelegates[photoCaptureProcessor.requestedPhotoSettings.uniqueID] = nil
                    }
                }, photoProcessingHandler: { [weak self] animate in
                    // Animates a spinner while photo is processing
                    if animate {
                        self?.shouldShowSpinner = true
                    } else {
                        self?.shouldShowSpinner = false
                    }
                })
                
                // The photo output holds a weak reference to the photo capture delegate and stores it in an array to maintain a strong reference.
                self.inProgressPhotoCaptureDelegates[photoCaptureProcessor.requestedPhotoSettings.uniqueID] = photoCaptureProcessor
                self.photoOutput.capturePhoto(with: photoSettings, delegate: photoCaptureProcessor)
            }
        }
    }

    public func setTimer(_ time:Int?) {
        self.timerTime = time
    }

    public func runTimer() {
        self.time = self.timerTime
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.currentTimer = timer
            
            if(self.time != nil){
                self.time! -= 1
            }else{
                timer.invalidate()
            }

            if self.time == 0 {
                timer.invalidate()
            }
        }
    }
    
    public func stopTimer() {
        self.currentTimer!.invalidate()
        self.time = nil
    }
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        if(visionTimer + 0.5 < NSDate().timeIntervalSince1970){
            if let pixelBuffer = sampleBuffer.imageBuffer {
                // Attempt to lock the image buffer to gain access to its memory.
                guard CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly) == kCVReturnSuccess
                    else {
                        return
                }

                // Create Core Graphics image placeholder.
                var image: CGImage?

                // Create a Core Graphics bitmap image from the pixel buffer.
                VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &image)

                // Release the image buffer.
                CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)

                DispatchQueue.main.sync {
                    if(image != nil) {
                        visionTimer = NSDate().timeIntervalSince1970
                        currentFrame = image!
                        currentFrameImage = UIImage(cgImage: image!)
                        // Create a new image-request handler.
                        let requestHandler = VNImageRequestHandler(cgImage: currentFrame!)
                        
                        // Create a new request to recognize a human body pose.
                        let request = VNDetectHumanBodyPoseRequest(completionHandler: bodyPoseHandler)

                        do {
                            // Perform the body pose-detection request.
                            try requestHandler.perform([request])
                        } catch {
                            print("Unable to perform the request: \(error).")
                        }
                    }
                }
            }
        }
    }
    
    func bodyPoseHandler(request: VNRequest, error: Error?) {
        guard let observations =
                request.results as? [VNHumanBodyPoseObservation] else {
            return
        }
        
        // Process each observation to find the recognized body pose points.
        observations.forEach { processObservation($0) }
        
        if(observations.isEmpty) {
            bodyPoints = []
        }
    }
    
    func processObservation(_ observation: VNHumanBodyPoseObservation) {
        
        // Retrieve all torso points.
        guard let recognizedPoints =
                try? observation.recognizedPoints(.all) else { return }
        
        // Torso joint names in a clockwise ordering.
        let torsoJointNames: [VNHumanBodyPoseObservation.JointName] = [
            .neck,
            .nose,
            .leftShoulder,
            .rightShoulder,
            .leftElbow,
            .rightElbow,
            .leftWrist,
            .rightWrist,
            .root,
            .leftHip,
            .rightHip,
            .leftKnee,
            .rightKnee,
            .leftAnkle,
            .rightAnkle
        ]
        
        // Retrieve the CGPoints containing the normalized X and Y coordinates.
        let imagePoints: [CGPoint] = torsoJointNames.compactMap {
            guard let point = recognizedPoints[$0], point.confidence > 0 else { return nil }
            
            // Translate the point from normalized-coordinates to image coordinates.
            return VNImagePointForNormalizedPoint(point.location,
                                                  Int(currentFrame!.width),
                                                  Int(currentFrame!.height))
        }
        
        // Draw the points on screen.
        drawPoints(points: imagePoints)
    }
    
    func drawPoints(points: [CGPoint]) {
        let dstImageSize = CGSize(width: currentFrame!.width, height: currentFrame!.height)
        let dstImageFormat = UIGraphicsImageRendererFormat()

        dstImageFormat.scale = 1
        let renderer = UIGraphicsImageRenderer(size: dstImageSize,
                                               format: dstImageFormat)

        var dstImage = renderer.image { rendererContext in
//            for point in points {
//
//                drawCircle(point: point, in: rendererContext.cgContext)
//            }
        }

//        let renderer2 = UIGraphicsImageRenderer(size: dstImageSize,
//                                                       format: dstImageFormat)
//        var dstImage2 = renderer2.image { rendererContext in
//            rendererContext.cgContext.saveGState()
//            // The given image is assumed to be upside down; therefore, the context
//            // is flipped before rendering the image.
//            rendererContext.cgContext.scaleBy(x: 1.0, y: -1.0)
//            // Render the image, adjusting for the scale transformation performed above.
//            let drawingRect = CGRect(x: 0, y: -currentFrame!.height, width: currentFrame!.width, height: currentFrame!.height)
//            rendererContext.cgContext.draw(currentFrame!, in: drawingRect)
//            rendererContext.cgContext.restoreGState()

//            for point in points {
//
//                drawCircle(point: point, in: rendererContext.cgContext)
//            }
//        }

        dstImage = dstImage.rotate(radians: .pi/2)
        image = dstImage

        bodyPoints = points
    }
    
//    private func drawCircle(point: CGPoint, in cgContext: CGContext) {
//        cgContext.setFillColor(CGColor.init(red: 1, green: 0.52700002193450928, blue: 0.07999997138977051, alpha: 1))
//
//        let rectangle = CGRect(x: point.x - 4, y: (CGFloat(currentFrame!.height) - point.y) - 4,
//                               width: 4 * 2, height: 4 * 2)
//        cgContext.addEllipse(in: rectangle)
//        cgContext.drawPath(using: .fill)
//    }
    
    func setZoom(scale: CGFloat) {
        var error:NSError!
            do{
                try self.videoDevice.lockForConfiguration()
                defer {self.videoDevice.unlockForConfiguration()}
                
                if (scale >= 1.0 && scale <= self.videoDevice.activeFormat.videoMaxZoomFactor){
                    self.videoDevice.videoZoomFactor = scale
                } else {
                    NSLog("Unable to set videoZoom: (max %f, asked %f)", self.videoDevice.activeFormat.videoMaxZoomFactor, scale);
                }
            }catch error as NSError{
                 NSLog("Unable to set videoZoom: %@", error.localizedDescription);
            }catch _{
                
            }
    }
    
    func updateZoom(scale: CGFloat) {
        if(lastScale == nil) {
            lastScale = self.videoDevice.videoZoomFactor
        }
        
        if (scale >= 1 && lastScale! + (scale - 1) <= self.videoDevice.activeFormat.videoMaxZoomFactor){
            setZoom(scale: lastScale! + (scale - 1))
        }
        
        if (scale < 1 && lastScale! - (1 - scale) >= 1.0){
            setZoom(scale: lastScale! * scale)
        }
    }
    
    func setFinalZoom(scale: CGFloat) {
        updateZoom(scale: scale)
        
        lastScale = nil
    }
}
