package com.spren.spren_flutter.commands;

import androidx.annotation.NonNull;
import com.spren.sprencapture.SprenCapture;
import com.spren.sprencore.Spren;
import com.spren.sprencore.Spren_PublicConfigKt;
import java.util.HashMap;
import java.util.Map;
import android.content.Context;
import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SprenViewCommands {
    private static final String TAG = "SprenViewCommands";
    private final SprenCapture sprenCapture;
    private final Context context;

    public SprenViewCommands(@NonNull SprenCapture sprenCapture, @NonNull Context context) {
        this.sprenCapture = sprenCapture;
        this.context = context;
    }

    public void receiveCommand(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals(SprenCommands.COMMAND_SET_TORCH_MODE.toString())) {
            assert call.arguments != null;
            assert call.arguments instanceof HashMap;
            Map<String, Integer> args = (Map<String, Integer>) call.arguments;
            boolean torch = 1 == args.get(SprenCommands.COMMAND_SET_TORCH_MODE_PARAM.toString());
            sprenCapture.setTorchMode(torch);
        } else if (call.method.equals(SprenCommands.COMMAND_SET_AUTO_START.toString())) {
            assert call.arguments != null;
            assert call.arguments instanceof HashMap;
            Map<String, Boolean> args = (Map<String, Boolean>) call.arguments;
            boolean autoStart = args.get(SprenCommands.COMMAND_SET_AUTO_START_PARAM.toString());
            Spren.Companion.setAutoStart(autoStart);
        } else if (call.method.equals(SprenCommands.COMMAND_CAPTURE_START.toString())) {
            sprenCapture.start();
        } else if (call.method.equals(SprenCommands.COMMAND_CAPTURE_STOP.toString())) {
            sprenCapture.stop();
        } else if (call.method.equals(SprenCommands.COMMAND_DROP_COMPLEXITY.toString())) {
            sprenCapture.dropComplexity();
        } else if (call.method.equals(SprenCommands.COMMAND_CANCEL_READING.toString())) {
            Spren_PublicConfigKt.cancelReading(Spren.Companion);
        } else if (call.method.equals(SprenCommands.COMMAND_GET_READING_DATA.toString())) {
            String readingData = Spren.Companion.getReadingData(context);
            result.success(readingData);
        } else {
            Log.v(TAG, String.format("no command %s", call.method));
        }
    }
}
