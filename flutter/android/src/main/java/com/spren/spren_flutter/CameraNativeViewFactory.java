package com.spren.spren_flutter;

import android.content.Context;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import java.util.Map;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class CameraNativeViewFactory extends PlatformViewFactory {
    FlutterActivity flutterActivity;
    BinaryMessenger binaryMessenger;

    CameraNativeViewFactory() {
        super(StandardMessageCodec.INSTANCE);
    }

    CameraNativeViewFactory(FlutterActivity flutterActivity, BinaryMessenger binaryMessenger) {
        this();
        this.flutterActivity = flutterActivity;
        this.binaryMessenger = binaryMessenger;
    }


    @NonNull
    @Override
    public PlatformView create(@NonNull Context context, int id, @Nullable Object args) {
        final Map<String, Object> creationParams = (Map<String, Object>) args;
        CameraNativeView cameraNativeView = new CameraNativeView(context, id, creationParams, binaryMessenger, flutterActivity);
        return cameraNativeView;
    }
}
