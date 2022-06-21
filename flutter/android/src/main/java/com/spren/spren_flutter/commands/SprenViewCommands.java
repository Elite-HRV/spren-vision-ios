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
            try {
                sprenCapture.setTorchMode(torch);
                result.success(null);
            } catch (Exception e) {
                result.error("100", "Unable to SprenCapture.setTorchMode", "SprenCapture.setTorchMode");
            }
        } else if (call.method.equals(SprenCommands.COMMAND_SET_AUTO_START.toString())) {
            assert call.arguments != null;
            assert call.arguments instanceof HashMap;
            Map<String, Boolean> args = (Map<String, Boolean>) call.arguments;
            boolean autoStart = args.get(SprenCommands.COMMAND_SET_AUTO_START_PARAM.toString());
            try {
                Spren.Companion.setAutoStart(autoStart);
                result.success(null);
            } catch (Exception e) {
                result.error("101", "Unable to Spren.setAutoStart", "Spren.setAutoStart");
            }
        } else if (call.method.equals(SprenCommands.COMMAND_CAPTURE_START.toString())) {
            try {
                sprenCapture.start();
                result.success(null);
            } catch (Exception e) {
                result.error("102", "Unable to SprenCapture.start", "SprenCapture.start");
            }
        } else if (call.method.equals(SprenCommands.COMMAND_HANDLE_OVER_EXPOSURE.toString())) {
            try {
                sprenCapture.handleOverExposure();
                result.success(null);
            } catch (Exception e) {
                result.error("103", "Unable to SprenCapture.handleOverExposure", "SprenCapture.handleOverExposure");
            }
        } else if (call.method.equals(SprenCommands.COMMAND_CAPTURE_STOP.toString())) {
            try {
                sprenCapture.stop();
                result.success(null);
            } catch (Exception e) {
                result.error("104", "Unable to SprenCapture.stop", "SprenCapture.stop");
            }
        } else if (call.method.equals(SprenCommands.COMMAND_DROP_COMPLEXITY.toString())) {
            try {
                sprenCapture.dropComplexity();
                result.success(null);
            } catch (Exception e) {
                result.error("105", "Unable to SprenCapture.dropComplexity", "SprenCapture.dropComplexity");
            }
        } else if (call.method.equals(SprenCommands.COMMAND_CANCEL_READING.toString())) {
            try {
                Spren_PublicConfigKt.cancelReading(Spren.Companion);
                result.success(null);
            } catch (Exception e) {
                result.error("106", "Unable to Spren.cancelReading", "Spren.cancelReading");
            }
        } else if (call.method.equals(SprenCommands.COMMAND_GET_READING_DATA.toString())) {
            try {
                String readingData = Spren.Companion.getReadingData(context);
                result.success(readingData);
            } catch (Exception e) {
                result.error("107", "Unable to Spren.getReadingData", "Spren.getReadingData");
            }
        } else {
            Log.v(TAG, String.format("no command %s", call.method));
            result.error("999", String.format("no command %s", call.method), null);
        }
    }
}
