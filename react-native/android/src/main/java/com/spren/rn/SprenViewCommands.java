package com.spren.rn;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.facebook.react.bridge.ReadableArray;
import com.spren.rn.commands.SprenCommands;
import com.spren.rn.events.SprenEvents;
import com.spren.sprencapture.SprenCapture;
import com.spren.sprencore.Spren;
import com.spren.sprencore.Spren_PublicConfigKt;

import java.util.logging.Level;
import java.util.logging.Logger;

public class SprenViewCommands {
    SprenCapture sprenCapture;
    SprenView sprenView;
    private static Logger logger = Logger.getLogger(SprenViewCommands.class.toString());

    public SprenViewCommands(@NonNull SprenCapture sprenCapture, @NonNull SprenView sprenView) {
        this.sprenCapture = sprenCapture;
        this.sprenView = sprenView;
    }

    public void receiveCommand(String command, @Nullable ReadableArray args) {
        if (command.equals(SprenCommands.COMMAND_SET_TORCH_MODE.toString())) {
            assert args != null;
            boolean torch = "1".equals(args.getString(0));
            sprenCapture.setTorchMode(torch);
        } else if (command.equals(SprenCommands.COMMAND_SET_AUTO_START.toString())) {
            assert args != null;
            boolean autoStart = args.getBoolean(0);
            Spren.Companion.setAutoStart(autoStart);
        } else if (command.equals(SprenCommands.COMMAND_CAPTURE_START.toString())) {
            sprenCapture.start();
        } else if (command.equals(SprenCommands.COMMAND_HANDLE_OVER_EXPOSURE.toString())) {
            sprenCapture.handleOverExposure();
        } else if (command.equals(SprenCommands.COMMAND_CAPTURE_STOP.toString())) {
            sprenCapture.stop();
        } else if (command.equals(SprenCommands.COMMAND_DROP_COMPLEXITY.toString())) {
            sprenCapture.dropComplexity();
        } else if (command.equals(SprenCommands.COMMAND_CANCEL_READING.toString())) {
            Spren_PublicConfigKt.cancelReading(Spren.Companion);
        } else if (command.equals(SprenCommands.COMMAND_GET_READING_DATA.toString())) {
            String readingData = Spren.Companion.getReadingData(sprenView.getContext());
            SprenEvents.emitReadingDataReadyEvent(sprenView, readingData);
        } else {
            logger.log(Level.WARNING, "no command %s", command);
        }
    }
}
