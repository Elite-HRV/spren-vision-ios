//
//  CameraConfig.swift
//  
//
//  Created by nick on 17.12.2021.
//

import Foundation
import AVFoundation

struct CameraConfig {
    static let frameRate = 120
    static let resHeight = 720
    static let resWidth  = 1280
    
    static let filter: (AVCaptureDevice.Format) -> Bool = { format in
        let dims = CMVideoFormatDescriptionGetDimensions(format.formatDescription)
        let cond1 = resHeight == dims.height && resWidth == dims.width
        let cond2 = format.videoSupportedFrameRateRanges.contains { $0.maxFrameRate >= Float64(frameRate) }
        return cond1 && cond2
    }

    static let videoOrientation: AVCaptureVideoOrientation = .portrait
}
