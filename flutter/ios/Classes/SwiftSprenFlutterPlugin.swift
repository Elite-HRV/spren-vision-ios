import Flutter
import UIKit

public class SwiftSprenFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let methodChannel = FlutterMethodChannel(name: SprenChannel.SPREN_FLUTTER_METHOD, binaryMessenger: registrar.messenger())
        
        let eventHandlers = getEventHandlers(with: registrar)
        let cameraNativeViewFactory = CameraNativeViewFactory(
            method: methodChannel,
            events: eventHandlers
        )
        registrar.register(cameraNativeViewFactory, withId: SprenChannel.SPREN_CAMERA_VIEW)
    }
    
    private static func getEventHandlers(with registrar: FlutterPluginRegistrar) -> (StateChangeHandler, PreReadingComplianceCheckHandler, ProgressUpdateHandler) {
        let stateChangeHandler = StateChangeHandler()
        FlutterEventChannel(name: SprenChannel.SPREN_FLUTTER_EVENT_STATE_CHANGE, binaryMessenger: registrar.messenger()).setStreamHandler(stateChangeHandler)
        
        let preReadingComplianceCheckHandler = PreReadingComplianceCheckHandler()
        FlutterEventChannel(name: SprenChannel.SPREN_FLUTTER_EVENT_PRE_READING_COMPLIANCE_CHECK, binaryMessenger: registrar.messenger()).setStreamHandler(preReadingComplianceCheckHandler)
        
        let progressUpdateHandler = ProgressUpdateHandler()
        FlutterEventChannel(name: SprenChannel.SPREN_FLUTTER_EVENT_PROGRESS_UPDATE, binaryMessenger: registrar.messenger()).setStreamHandler(progressUpdateHandler)

        return (stateChangeHandler, preReadingComplianceCheckHandler, progressUpdateHandler)
    }
}
