package com.spren.spren_flutter;

import androidx.annotation.NonNull;
import com.spren.spren_flutter.stream.PreReadingComplianceCheckHandler;
import com.spren.spren_flutter.stream.ProgressUpdateHandler;
import com.spren.spren_flutter.stream.StateChangeHandler;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.platform.PlatformViewRegistry;

/**
 * SprenFlutterPlugin
 */

public class SprenFlutterPlugin implements FlutterPlugin, ActivityAware {
    private BinaryMessenger binaryMessenger;
    private PlatformViewRegistry platformViewRegistry;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        binaryMessenger = flutterPluginBinding.getBinaryMessenger();
        binaryMessenger.enableBufferingIncomingMessages();
        platformViewRegistry = flutterPluginBinding.getPlatformViewRegistry();
        setEventHandlers(binaryMessenger);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        FlutterActivity flutterActivity = (FlutterActivity) binding.getActivity();
        CameraNativeViewFactory cameraNativeViewFactory = new CameraNativeViewFactory(flutterActivity, binaryMessenger);
        platformViewRegistry.registerViewFactory(SprenChannel.SPREN_CAMERA_VIEW.toString(), cameraNativeViewFactory);
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) { }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) { }

    @Override
    public void onDetachedFromActivity() { }

    @Override
    public void onDetachedFromActivityForConfigChanges() { }

    private void setEventHandlers(BinaryMessenger binaryMessenger) {
        new EventChannel(binaryMessenger, SprenChannel.SPREN_FLUTTER_EVENT_STATE_CHANGE.toString())
                .setStreamHandler(StateChangeHandler.getInstance());
        new EventChannel(binaryMessenger, SprenChannel.SPREN_FLUTTER_EVENT_PRE_READING_COMPLIANCE_CHECK.toString())
                .setStreamHandler(PreReadingComplianceCheckHandler.getInstance());
        new EventChannel(binaryMessenger, SprenChannel.SPREN_FLUTTER_EVENT_PROGRESS_UPDATE.toString())
                .setStreamHandler(ProgressUpdateHandler.getInstance());
    }
}
