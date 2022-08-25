//
//  VideoPreview.swift
//  SprenUI
//
//  Created by Keith Carolus on 11/11/21.
//

import Foundation
import UIKit
import AVKit
import SwiftUI

class VideoPreview: UIView {

    var videoPreviewLayer: AVCaptureVideoPreviewLayer? {
        return layer as? AVCaptureVideoPreviewLayer
    }

    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

struct VideoPreviewView: UIViewRepresentable {

    var session: AVCaptureSession

    let videoOrientation = AVCaptureVideoOrientation.portrait
    let videoGravity = AVLayerVideoGravity.resizeAspectFill
    
    func makeUIView(context: UIViewRepresentableContext<VideoPreviewView>) -> VideoPreview {
        let vp = VideoPreview()
        vp.videoPreviewLayer?.session = session
        vp.videoPreviewLayer?.connection?.videoOrientation = videoOrientation
        vp.videoPreviewLayer?.videoGravity = videoGravity
        return vp
    }

    func updateUIView(_ videoPreview: VideoPreview, context: UIViewRepresentableContext<VideoPreviewView>) {

    }
}
