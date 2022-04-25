package com.spren.spren_flutter.commands;

public enum SprenCommands {
    COMMAND_CANCEL_READING("cancelReading"),
    COMMAND_SET_AUTO_START("setAutoStart"),
    COMMAND_GET_READING_DATA("getReadingData"),
    COMMAND_CAPTURE_START("captureStart"),
    COMMAND_CAPTURE_STOP("captureStop"),
    COMMAND_DROP_COMPLEXITY("dropComplexity"),
    COMMAND_SET_TORCH_MODE("setTorchMode"),

    COMMAND_SET_AUTO_START_PARAM("autoStart"),
    COMMAND_SET_TORCH_MODE_PARAM("torchMode");

    private final String name;

    SprenCommands(final String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
