package com.spren.rn;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.ViewGroupManager;
import com.spren.rn.events.SprenEvents;
import java.util.Map;

public class SprenViewManager extends ViewGroupManager<SprenView> {
    public static final String REACT_CLASS = "SprenView";

    @Override
    @NonNull
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    @NonNull
    public SprenView createViewInstance(ThemedReactContext reactContext) {
        return new SprenView(reactContext);
    }

    @Nullable
    @Override
    public Map getExportedCustomBubblingEventTypeConstants() {
        return MapBuilder.builder()
            .put(SprenEvents.EVENT_ON_PROGRESS_UPDATE.toString(),
                MapBuilder.of(
                "phasedRegistrationNames",
                MapBuilder.of("bubbled", SprenEvents.EVENT_ON_PROGRESS_UPDATE.toString())))
            .put(SprenEvents.EVENT_ON_STATE_CHANGE.toString(),
                MapBuilder.of(
                "phasedRegistrationNames",
                MapBuilder.of("bubbled", SprenEvents.EVENT_ON_STATE_CHANGE.toString())))
            .put( SprenEvents.EVENT_ON_PREREADING_COMPLIANCE_CHECK.toString(),
                MapBuilder.of(
                "phasedRegistrationNames",
                MapBuilder.of("bubbled", SprenEvents.EVENT_ON_PREREADING_COMPLIANCE_CHECK.toString())))
            .put(SprenEvents.EVENT_ON_READING_DATA_READY.toString(),
                MapBuilder.of(
                "phasedRegistrationNames",
                MapBuilder.of("bubbled", SprenEvents.EVENT_ON_READING_DATA_READY.toString())))
            .build();
    }

    @Override
    public void receiveCommand(@NonNull SprenView sprenView, String command, @Nullable ReadableArray args) {
        sprenView.receiveCommand(command, args);
    }
}
