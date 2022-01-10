//
//  AVCaptureFormat+FrameRate.swift
//  
//
//  Created by Keith Carolus on 1/10/22.
//

import Foundation
import AVFoundation

extension AVCaptureDevice.Format {
    
    var frameRate: Double {
        return self.videoSupportedFrameRateRanges[0].maxFrameRate
    }
    
    var resolution: Int {
        let dims = CMVideoFormatDescriptionGetDimensions(self.formatDescription)
        return Int(dims.width*dims.height)
    }
    
}
