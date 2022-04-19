package com.spren.rn.events;

import android.view.ViewGroup;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.spren.sprencore.SprenState;
import com.spren.sprencore.finger.compliance.ComplianceCheck;
import com.spren.sprencore.finger.compliance.SprenComplianceError;
import java.util.HashMap;
import java.util.Map;

public enum SprenEvents {
    EVENT_ON_STATE_CHANGE("onStateChange"),
    EVENT_ON_PREREADING_COMPLIANCE_CHECK("onPrereadingComplianceCheck"),
    EVENT_ON_PROGRESS_UPDATE("onProgressUpdate"),
    EVENT_ON_READING_DATA_READY("onReadingDataReady");

    private final String name;
    private final static Map<ComplianceCheck.Name, String> complianceNameMap = new HashMap() {{
        put(ComplianceCheck.Name.BRIGHTNESS, "brightness");
        put(ComplianceCheck.Name.FRAME_DROP, "frameDrop");
        put(ComplianceCheck.Name.LENS_COVERAGE, "lensCoverage");
    }};
    private final static Map<ComplianceCheck.Action, String> complianceActionMap = new HashMap() {{
        put(ComplianceCheck.Action.INCREASE, "increase");
        put(ComplianceCheck.Action.DECREASE, "decrease");
    }};

    private final static Map<SprenState, String> complianceStateMap = new HashMap() {{
        put(SprenState.STARTED, "started");
        put(SprenState.FINISHED, "finished");
        put(SprenState.CANCELLED, "cancelled");
        put(SprenState.ERROR, "error");
    }};

    SprenEvents(final String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }

    public static void emitProgressUpdateEvent(final ViewGroup view, Integer progress) {
        WritableMap map = Arguments.createMap();
        map.putInt("progress", progress);

        final ReactContext reactContext = (ReactContext) view.getContext();
        reactContext
            .getJSModule(RCTEventEmitter.class)
            .receiveEvent(view.getId(), SprenEvents.EVENT_ON_PROGRESS_UPDATE.toString(), map);
    }

    public static void emitStateChangeEvent(final ViewGroup view, SprenState sprenState, SprenComplianceError sprenComplianceError) {
        WritableMap map = Arguments.createMap();
        map.putString("state", complianceStateMap.get(sprenState));

        final ReactContext reactContext = (ReactContext) view.getContext();
        reactContext
            .getJSModule(RCTEventEmitter.class)
            .receiveEvent(view.getId(), SprenEvents.EVENT_ON_STATE_CHANGE.toString(), map);
    }

    public static void emitPrereadingComplianceCheckEvent(final ViewGroup view, ComplianceCheck.Name name, Boolean isCompliant, ComplianceCheck.Action action) {
        WritableMap map = Arguments.createMap();
        map.putString("name", complianceNameMap.get(name));
        map.putBoolean("compliant", isCompliant);
        if (action != null) {
            map.putString("action", complianceActionMap.get(action));
        }

        final ReactContext reactContext = (ReactContext) view.getContext();
        reactContext
            .getJSModule(RCTEventEmitter.class)
            .receiveEvent(view.getId(), SprenEvents.EVENT_ON_PREREADING_COMPLIANCE_CHECK.toString(), map);
    }

    public static void emitReadingDataReadyEvent(final ViewGroup view, String readingData) {
        WritableMap map = Arguments.createMap();
        map.putString("readingData", readingData);

        final ReactContext reactContext = (ReactContext) view.getContext();
        reactContext
            .getJSModule(RCTEventEmitter.class)
            .receiveEvent(view.getId(), SprenEvents.EVENT_ON_READING_DATA_READY.toString(), map);
    }
}
