//
//  SprenCaptureDelegate.swift
//  
//
//  Created by nick on 17.12.2021.
//

import Foundation
import AVFoundation
import SprenCore

class SprenCaptureDelegate: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {        
        Spren.process(frame: SprenFrame(sampleBuffer: sampleBuffer, orientation: connection.videoOrientation.rawValue))
    }

    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        Spren.frameDropped()
    }
    
}
