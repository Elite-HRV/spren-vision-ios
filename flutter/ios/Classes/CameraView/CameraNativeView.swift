//
//  CameraNativeView.swift
//  spren_flutter
//
//  Created by nick on 19.03.2022.
//

import Flutter
import UIKit
import SprenCore
import AVFoundation

class CameraNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var sprenCapture: SprenCapture
    var params: CameraNativeViewParams

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        spren sprenCapture: SprenCapture?
    ) {
        let argsDict: Dictionary<String, Any> = args as? Dictionary<String, Any> ?? [:]
        self.params = CameraNativeViewParams(dict: argsDict)
        self.sprenCapture = sprenCapture!
        _view = CameraUIView(sprenCapture: self.sprenCapture)

        super.init()
        
        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView){
        setupPreviewLayer()
        startCamera()
//            setupCallbacks()
    }
    
    func setupPreviewLayer() {
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: sprenCapture.session)
        self.videoPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill

        self._view.frame = CGRect(x: 0, y: 0, width: self.params.width, height: self.params.height)
        self.videoPreviewLayer?.frame = self._view.frame
        self._view.layer.insertSublayer(videoPreviewLayer!, at: 0)
    }

    func startCamera() {
        sprenCapture.start()
        print("SprenCapture started")
    }
}
