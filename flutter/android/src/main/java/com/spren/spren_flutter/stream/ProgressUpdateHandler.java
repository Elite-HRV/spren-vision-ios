package com.spren.spren_flutter.stream;

import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;

public class ProgressUpdateHandler implements StreamHandler {
    private static final ProgressUpdateHandler instance = new ProgressUpdateHandler();
    private EventSink eventSink;

    private ProgressUpdateHandler(){ }

    public static ProgressUpdateHandler getInstance() {
        return instance;
    }

    @Override
    public void onListen(Object arguments, EventSink eventSink) {
        this.eventSink = eventSink;
    }

    @Override
    public void onCancel(Object arguments) {
        this.eventSink = null;
    }

    public EventSink getEventSink() {
        return eventSink;
    }
}
