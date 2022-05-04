//
//  AVCaptureFormat+FrameRate.swift
//  
//
//  Created by Keith Carolus on 1/10/22.
//

import Foundation
import AVFoundation

extension AVCaptureDevice.Format {
    
    var frameRate: Int {
        return Int(videoSupportedFrameRateRanges[0].maxFrameRate)
    }
    
    var resolution: Int {
        let dims = CMVideoFormatDescriptionGetDimensions(self.formatDescription)
        return Int(dims.width*dims.height)
    }
    
    var hrsiSupported: Bool {
        let hrsiDims = highResolutionStillImageDimensions
        return resolution != Int(hrsiDims.width*hrsiDims.height)
    }
    
}
