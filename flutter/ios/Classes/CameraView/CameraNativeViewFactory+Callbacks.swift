//
//  CameraNativeView+Callbacks.swift
//  spren-flutter
//
//  Created by nick on 21.03.2022.
//

import Foundation
import SprenCore
import AVKit

extension CameraNativeViewFactory {
    func setupCallbacks(channel: FlutterMethodChannel) {
        channel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if (call.method == "setAutoStart") {
                guard let args = call.arguments as? [String : Any] else {
                    print("setAutoStart is not called without arguments")
                    return
                }
                let autoStart = args["autoStart"] as! Bool

                Spren.autoStart = autoStart
                result(nil)
            } else if (call.method == "setTorchMode") {
                guard let args = call.arguments as? [String : Any] else {
                    print("setTorchMode is not called without arguments")
                    return
                }
                let torchMode = args["torchMode"] as! Int
                let mode = AVCaptureDevice.TorchMode(rawValue: torchMode)
                try? self.sprenCapture?.setTorchMode(to: mode!)
                result(nil)
            } else if (call.method == "cancelReading") {
                Spren.cancelReading()
                result(nil)
            } else if (call.method == "captureStart") {
                self.sprenCapture?.start()
                result(nil)
            } else if (call.method == "captureStop") {
                self.sprenCapture?.stop()
                result(nil)
            } else if (call.method == "captureLock") {
                try? self.sprenCapture?.lock()
                result(nil)
            } else if (call.method == "captureUnlock") {
                try? self.sprenCapture?.unlock()
                result(nil)
            } else if (call.method == "dropComplexity") {
                try? self.sprenCapture?.dropComplexity()
                result(nil)
            } else if (call.method == "getReadingData") {
                let readingData: String? = Spren.getReadingData()
                result(readingData)
            } else {
                result(FlutterMethodNotImplemented)
            }
        })

        Spren.setOnStateChange { [weak self] state, error in
            self?.eventStateChange.eventSink?([
                "state": String(describing: state),
                "error": error
            ])
        }

        Spren.setOnPrereadingComplianceCheck { [weak self] name, compliant, action in
            let act = action == nil ? nil : String(describing: action!)
            self?.eventPreReadingComplianceCheckHandler.eventSink?([
                "name": String(describing: name),
                "action": act,
                "compliant": compliant
            ])
        }

        Spren.setOnProgressUpdate { [weak self] progress in
            self?.eventProgressUpdateHandler.eventSink?([
                "progress": progress
            ])
        }
    }
}
