//
//  CameraNativeViewFactory.swift
//  spren_flutter
//
//  Created by nick on 19.03.2022.
//

import Flutter
import UIKit
import SprenCore
import SprenVision

class CameraNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    var eventStateChange: StateChangeHandler
    var eventPreReadingComplianceCheckHandler: PreReadingComplianceCheckHandler
    var eventProgressUpdateHandler: ProgressUpdateHandler
    lazy var sprenCapture: SprenCapture? = {
       let sprenCapture = try? SprenCapture()
       return sprenCapture
    }()
    
    init(method methodChannel: FlutterMethodChannel, events eventHandlers: (StateChangeHandler, PreReadingComplianceCheckHandler, ProgressUpdateHandler)) {
        self.eventStateChange = eventHandlers.0
        self.eventPreReadingComplianceCheckHandler = eventHandlers.1
        self.eventProgressUpdateHandler = eventHandlers.2
        super.init()
        setupCallbacks(channel: methodChannel)
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return CameraNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            spren: sprenCapture
        )
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
