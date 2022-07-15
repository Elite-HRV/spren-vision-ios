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
        if (command.equals(SprenCommands.COMMAND_CAPTURE_START.toString())) {
            try {
                sprenCapture.start();
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Unable to run command %s", command);
            }
        } else if (command.equals(SprenCommands.COMMAND_CAPTURE_STOP.toString())) {
            try {
                sprenCapture.stop();
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Unable to run command %s", command);
            }
        } else if (command.equals(SprenCommands.COMMAND_CANCEL_READING.toString())) {
            try {
                Spren_PublicConfigKt.cancelReading(Spren.Companion);
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Unable to run command %s", command);
            }
        } else if (command.equals(SprenCommands.COMMAND_GET_READING_DATA.toString())) {
            try {
                String readingData = Spren.Companion.getReadingData(sprenView.getContext());
                SprenEvents.emitReadingDataReadyEvent(sprenView, readingData);
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Unable to run command %s", command);
            }
        } else if (command.equals(SprenCommands.COMMAND_RESET.toString())) {
            try {
                sprenCapture.reset();
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Unable to run command %s", command);
            }
        } else if (command.equals(SprenCommands.COMMAND_TURN_FLASH_ON.toString())) {
            try {
                sprenCapture.turnFlashOn();
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Unable to run command %s", command);
            }
        } else {
            logger.log(Level.WARNING, "no command %s", command);
        }
    }
}
