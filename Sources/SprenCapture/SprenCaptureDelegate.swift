//
//  SprenCaptureDelegate.swift
//  
//
//  Created by nick on 17.12.2021.
//

import Foundation
import AVFoundation
import SprenVision

class SprenCaptureDelegate: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {        
        Spren.process(frame: SprenFrame(sampleBuffer: sampleBuffer, orientation: connection.videoOrientation.rawValue))
    }

    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        Spren.frameDropped()
    }

//    func setCameraConfig (callback: @escaping () -> Void) {
//        guard let videoDevice = self.getVideoDevice() else { return }
//
//        do {
//            try videoDevice.lockForConfiguration()
//
//            if videoDevice.isWhiteBalanceModeSupported(.locked) {
//                videoDevice.whiteBalanceMode = AVCaptureDevice.WhiteBalanceMode.locked
//            }
//
//            if videoDevice.isFocusModeSupported(.locked) {
//                videoDevice.focusMode = AVCaptureDevice.FocusMode.locked
//            }
//
//            if videoDevice.isExposureModeSupported(.locked) {
//                videoDevice.exposureMode = AVCaptureDevice.ExposureMode.locked
//            }
//
//            if videoDevice.isFocusModeSupported(.locked) {
//                videoDevice.focusMode = AVCaptureDevice.FocusMode.locked
//            }
//
//            videoDevice.setExposureModeCustom(duration: videoDevice.exposureDuration, iso: videoDevice.iso, completionHandler: { (_) in
//                videoDevice.unlockForConfiguration()
//                callback()
//            })
//        } catch {
//            print("setCameraConfig failed with error: \(error.localizedDescription)")
//        }
//    }

//    public func onStart(completion callback: @escaping (() -> Void)) -> Void {
//        print("onStart")
////        self.setCameraConfig(callback: callback)
//    }
//
//    public func onStageChanged(state: SprenState, error: Error?) {
//        print("onStageChanged", state, error)
//    }
//
//    public func onProgressUpdate(progress: Int) {
//        print("onProgressUpdate", progress)
//    }

//    func getVideoDevice() -> AVCaptureDevice? {
//        return .default(.builtInWideAngleCamera, for: .video, position: .back)
//    }

//    func isCameraFeedCompliant(compliances: [Compliances]) {
//        for compliance in compliances {
//            debugPrint("compliance:", compliance.name, "isCompliant:", compliance.isCompliant)
////            debugPrint("is brightness:", compliance.name == Compliance.brightness)
//        }
//    }

//    func cameraFormat(format: AVCaptureDevice.Format?) {
//        guard let videoDevice = self.getVideoDevice() else { return }
//        do { try videoDevice.lockForConfiguration()
//        videoDevice.activeFormat = format!
//        videoDevice.unlockForConfiguration()
//        } catch {
//            print("LockForConfiguration failed with error: \(error.localizedDescription)")
//        }
//    }
}
