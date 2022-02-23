//
//  SprenView+Callbacks.swift
//  spren-ios-sdk
//
//  Created by nick on 23.02.2022.
//

import Foundation
import SprenCore
import AVKit

extension SprenView {
    func setupCallbacks() {
        Spren.setOnStateChange { [weak self] state, error in
            self?.onStateChange?(["state": String(describing: state), "error": error?.localizedDescription])
        }

        Spren.setOnPrereadingComplianceCheck { [weak self] name, compliant, action in
            let act = action == nil ? nil : String(describing: action!)
            self?.onPrereadingComplianceCheck?(["name": String(describing: name), "action": act, "compliant": compliant])
        }

        Spren.setOnProgressUpdate { [weak self] progress in
            self?.onProgressUpdate?(["progress": progress])
        }
    }
    
    func cancelReading() {
        Spren.cancelReading()
    }
    
    func setAutoStart(_ autoStart: Bool) {
        Spren.autoStart = autoStart
    }
    
    func getReadingData() {
        let readingData: String? = Spren.getReadingData()
        self.onReadingDataReady?(["readingData": readingData])
    }
    
    func captureStart() {
        sprenCapture?.start()
    }
    
    func captureStop() {
        sprenCapture?.stop()
    }
    
    func captureLock() {
        try? sprenCapture?.lock()
    }
    
    func captureUnlock() {
        try? sprenCapture?.unlock()
    }
    
    func dropComplexity() {
        try? sprenCapture?.dropComplexity()
    }
    
    func setTorchMode(_ torchMode: NSNumber) {
        let mode = AVCaptureDevice.TorchMode(rawValue: Int(truncating: torchMode))!
        try? sprenCapture?.setTorchMode(to: mode)
    }
}
