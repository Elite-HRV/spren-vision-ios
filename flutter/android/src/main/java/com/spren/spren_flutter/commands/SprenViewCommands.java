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
        if (call.method.equals(SprenCommands.COMMAND_CAPTURE_START.toString())) {
            try {
                sprenCapture.start();
                result.success(null);
            } catch (Exception e) {
                result.error("102", "Unable to SprenCapture.start", "SprenCapture.start");
            }
        } else if (call.method.equals(SprenCommands.COMMAND_CAPTURE_STOP.toString())) {
            try {
                sprenCapture.stop();
                result.success(null);
            } catch (Exception e) {
                result.error("104", "Unable to SprenCapture.stop", "SprenCapture.stop");
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
        } else if (call.method.equals(SprenCommands.COMMAND_RESET.toString())) {
            try {
                sprenCapture.reset();
                result.success(true);
            } catch (Exception e) {
                result.error("108", "Unable to sprenCapture.reset", "sprenCapture.reset");
            }
        } else if (call.method.equals(SprenCommands.COMMAND_TURN_FLASH_ON.toString())) {
            try {
                sprenCapture.turnFlashOn();
                result.success(true);
            } catch (Exception e) {
                result.error("109", "Unable to turnFlashOn", "turnFlashOn");
            }
        } else {
            Log.v(TAG, String.format("no command %s", call.method));
            result.error("999", String.format("no command %s", call.method), null);
        }
    }
}
