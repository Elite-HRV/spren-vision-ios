package com.spren.spren_flutter.stream;

import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugin.common.EventChannel.EventSink;

public class StateChangeHandler implements StreamHandler {
    private static final StateChangeHandler instance = new StateChangeHandler();
    private EventSink eventSink;

    private StateChangeHandler(){ }

    public static StateChangeHandler getInstance() {
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
