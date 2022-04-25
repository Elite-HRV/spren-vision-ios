package com.spren.spren_flutter;

import com.spren.sprencore.SprenState;
import com.spren.sprencore.finger.compliance.ComplianceCheck;
import java.util.HashMap;
import java.util.Map;

public enum SprenChannel {
    SPREN_FLUTTER_METHOD("com.spren/spren_flutter_method"),

    SPREN_FLUTTER_EVENT_STATE_CHANGE("com.spren/spren_flutter_event_state_change"),
    SPREN_FLUTTER_EVENT_PRE_READING_COMPLIANCE_CHECK("com.spren/spren_flutter_event_pre_reading_compliance_check"),
    SPREN_FLUTTER_EVENT_PROGRESS_UPDATE("com.spren/spren_flutter_event_progress_update"),

    SPREN_CAMERA_VIEW("cameraView");

    final static Map<ComplianceCheck.Name, String> COMPLIANCE_NAME_MAP = new HashMap() {{
        put(ComplianceCheck.Name.BRIGHTNESS, "brightness");
        put(ComplianceCheck.Name.FRAME_DROP, "frameDrop");
        put(ComplianceCheck.Name.LENS_COVERAGE, "lensCoverage");
    }};
    final static Map<ComplianceCheck.Action, String> COMPLIANCE_ACTION_MAP = new HashMap() {{
        put(ComplianceCheck.Action.INCREASE, "increase");
        put(ComplianceCheck.Action.DECREASE, "decrease");
    }};

    final static Map<SprenState, String> COMPLIANCE_STATE_MAP = new HashMap() {{
        put(SprenState.STARTED, "started");
        put(SprenState.FINISHED, "finished");
        put(SprenState.CANCELLED, "cancelled");
        put(SprenState.ERROR, "error");
    }};

    public final String channel;

    private SprenChannel(String channel) {
        this.channel = channel;
    }

    public String toString() {
        return this.channel;
    }
}
