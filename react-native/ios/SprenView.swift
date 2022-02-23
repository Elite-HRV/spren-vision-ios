//
//  SprenView.swift
//  spren-ios-sdk
//
//  Created by nick on 22.02.2022.
//

import Foundation
import AVKit

class SprenView : UIView {
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?

    @objc var width: NSNumber = 0
    @objc var height: NSNumber = 0


    override func didSetProps(_ changedProps: [String]!) {
        do {
            let sprenCapture = try SprenCapture()
            setupPreviewLayer(with: sprenCapture.session)
            startCamera(sprenCapture)
        } catch {
            print("SprenCapture failed to initiate")
            print(error.localizedDescription)
            return
        }
    }

    func setupPreviewLayer(with session: AVCaptureSession) {
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        self.videoPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill

        self.frame = CGRect(x: 0, y: 0, width: Double(truncating: self.width), height: Double(truncating: self.height))
        self.videoPreviewLayer?.frame = self.frame
        self.layer.insertSublayer(videoPreviewLayer!, at: 0)
    }

    func startCamera(_ sprenCapture: SprenCapture) {
        sprenCapture.start()
        print("SprenCapture started")
    }
}
