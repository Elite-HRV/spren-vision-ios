package com.spren.spren_flutter;
import android.app.Activity;
import android.content.Context;
import android.view.View;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;
import java.util.Map;

public class CameraNativeView implements PlatformView {
    private SprenView sprenView;

    CameraNativeView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams, BinaryMessenger binaryMessenger, Activity flutterActivity) {
        sprenView = new SprenView(context, binaryMessenger, flutterActivity);
    }

    @NonNull
    @Override
    public View getView() {
        return sprenView;
    }

    @Override
    public void dispose() {}
}
