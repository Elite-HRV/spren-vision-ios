package com.spren.spren_flutter.commands;

public enum SprenCommands {
    COMMAND_CANCEL_READING("cancelReading"),
    COMMAND_GET_READING_DATA("getReadingData"),
    COMMAND_CAPTURE_START("captureStart"),
    COMMAND_CAPTURE_STOP("captureStop"),
    COMMAND_RESET("reset"),
    COMMAND_TURN_FLASH_ON("turnFlashOn");

    private final String name;

    SprenCommands(final String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
