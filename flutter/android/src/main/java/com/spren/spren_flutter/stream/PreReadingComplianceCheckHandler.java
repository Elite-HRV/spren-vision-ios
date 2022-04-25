package com.spren.spren_flutter.stream;

import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;

public class PreReadingComplianceCheckHandler implements StreamHandler {
    private static final PreReadingComplianceCheckHandler instance = new PreReadingComplianceCheckHandler();
    private EventSink eventSink;

    private PreReadingComplianceCheckHandler(){ }

    public static PreReadingComplianceCheckHandler getInstance() {
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
