//
//  SprenView.swift
//  spren-ios-sdk
//
//  Created by nick on 22.02.2022.
//

import Foundation
import AVKit
import SprenCore
import SprenVision

class SprenView : UIView {
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var sprenCapture: SprenCapture? = nil
    @objc var width: NSNumber = 0
    @objc var height: NSNumber = 0
    @objc var onStateChange: RCTBubblingEventBlock?
    @objc var onPrereadingComplianceCheck: RCTBubblingEventBlock?
    @objc var onProgressUpdate: RCTBubblingEventBlock?
    @objc var onReadingDataReady: RCTBubblingEventBlock?

    override func didSetProps(_ changedProps: [String]!) {
        do {
            sprenCapture = try SprenCapture()
            setupPreviewLayer()
            startCamera()
            setupCallbacks()
        } catch {
            print("SprenCapture failed to initiate")
            print(error.localizedDescription)
            return
        }
    }

    func setupPreviewLayer() {
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: sprenCapture!.session)
        self.videoPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill

        self.frame = CGRect(x: 0, y: 0, width: Double(truncating: self.width), height: Double(truncating: self.height))
        self.videoPreviewLayer?.frame = self.frame
        self.layer.insertSublayer(videoPreviewLayer!, at: 0)
    }

    func startCamera() {
        sprenCapture!.start()
        print("SprenCapture started")
    }
}
