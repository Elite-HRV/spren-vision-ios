package com.spren.spren_flutter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.FrameLayout;
import androidx.annotation.NonNull;
import androidx.camera.view.PreviewView;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import com.spren.spren_flutter.commands.SprenViewCommands;
import com.spren.spren_flutter.stream.PreReadingComplianceCheckHandler;
import com.spren.spren_flutter.stream.ProgressUpdateHandler;
import com.spren.spren_flutter.stream.StateChangeHandler;
import com.spren.sprencapture.SprenCapture;
import com.spren.sprencore.Spren;
import com.spren.sprencore.SprenState;
import com.spren.sprencore.Spren_PublicConfigKt;
import com.spren.sprencore.event.SprenEvent;
import com.spren.sprencore.event.SprenEventManager;
import com.spren.sprencore.finger.compliance.ComplianceCheck;
import java.util.HashMap;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import kotlin.Unit;
import kotlin.jvm.functions.Function1;

public class SprenView extends FrameLayout implements MethodChannel.MethodCallHandler {
    private FlutterActivity flutterActivity;
    private SprenCapture sprenCapture;
    private Context context;
    private CoordinatorLayout container;
    private CoordinatorLayout children;
    private MethodChannel methodChannel;
    private SprenViewCommands sprenViewCommands;

    public SprenView(@NonNull Context context, BinaryMessenger binaryMessenger, FlutterActivity flutterActivity) {
        super(context);
        this.context = context;
        this.flutterActivity = flutterActivity;

        methodChannel = new MethodChannel(binaryMessenger, SprenChannel.SPREN_FLUTTER_METHOD.toString());
        methodChannel.setMethodCallHandler(this);

        PreviewView previewView = setupViews();
        sprenCapture = new SprenCapture(flutterActivity, previewView.getSurfaceProvider());
        sprenViewCommands = new SprenViewCommands(sprenCapture, context);
        setSprenCallbacks();
        startSpren();
    }

    /**
     * Override the adding view to make sure to display camera feed on the back of ReactNative View Group
     * @param child
     * @param index
     */
    @Override
    public void addView(View child, int index) {
        if (child instanceof PreviewView) {
            container.addView(child);
            return;
        }
        children.addView(child, index);
    }

    /**
     * Stop when view is removed
     */
    @Override
    protected void onDetachedFromWindow() {
        sprenCapture.stop();
        SprenEventManager.INSTANCE.unsubscribe(SprenEvent.STATE, this.stateListener);
        SprenEventManager.INSTANCE.unsubscribe(SprenEvent.COMPLIANCE, this.complianceListener);
        SprenEventManager.INSTANCE.unsubscribe(SprenEvent.PROGRESS, this.progressListener);

        methodChannel.setMethodCallHandler(null);
        super.onDetachedFromWindow();
    }

    /**
     * Receive call from flutter
     * @param call
     * @param result
     */
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        sprenViewCommands.receiveCommand(call, result);
    }

    private final Function1<? super HashMap<String, Object>, Unit> stateListener = (HashMap<String, Object> map) -> {
        SprenState state = (SprenState) map.get("state");
        flutterActivity.runOnUiThread(new Runnable() {
            public void run() {
                StateChangeHandler.getInstance().getEventSink().success(new HashMap<String, String>(){{
                    put("state", SprenChannel.COMPLIANCE_STATE_MAP.get(state));
                }});
            }
        });

        return null;
    };

    private final Function1<? super HashMap<String, Object>, Unit> complianceListener = (HashMap<String, Object> map) -> {
        ComplianceCheck.Name name = (ComplianceCheck.Name) map.get("name");
        Boolean isCompliant = (Boolean) map.get("isCompliant");
        flutterActivity.runOnUiThread(new Runnable() {
            public void run() {
                PreReadingComplianceCheckHandler.getInstance().getEventSink().success(new HashMap<String, Object>(){{
                    put("name", SprenChannel.COMPLIANCE_NAME_MAP.get(name));
                    put("compliant", isCompliant);
                }});
            }
        });
        return null;
    };

    private final Function1<? super HashMap<String, Object>, Unit> progressListener = (HashMap<String, Object> map) -> {
        Integer progress = (Integer) map.get("progress");
        flutterActivity.runOnUiThread(new Runnable() {
            public void run() {
                ProgressUpdateHandler.getInstance().getEventSink().success(new HashMap<String, Integer>(){{
                    put("progress", progress);
                }});
            }
        });
        return null;
    };

    /**
     * Set Spren callbacks to flutter
     */
    private void setSprenCallbacks() {
        SprenEventManager.INSTANCE
                .unsubscribe(SprenEvent.STATE, this.stateListener)
                .subscribe(SprenEvent.STATE, this.stateListener);
        SprenEventManager.INSTANCE
                .unsubscribe(SprenEvent.COMPLIANCE, this.stateListener)
                .subscribe(SprenEvent.COMPLIANCE, this.complianceListener);
        SprenEventManager.INSTANCE
                .unsubscribe(SprenEvent.PROGRESS, this.stateListener)
                .subscribe(SprenEvent.PROGRESS, this.progressListener);
    }

    /**
     * Start Spren camera
     * @param camera preview view
     */
    private void startSpren() {
        sprenCapture.start();
    }

    /**
     * Setup Views
     * @return camera PreviewView
     */
    private PreviewView setupViews() {
        View view = LayoutInflater.from(context).inflate(R.layout.spren_view, this);
        container = (CoordinatorLayout) view.findViewById(R.id.container);
        children = (CoordinatorLayout) view.findViewById(R.id.children);

        PreviewView previewView = new PreviewView(context);
        previewView.setLayoutParams(new LayoutParams(
            LayoutParams.MATCH_PARENT,
            LayoutParams.MATCH_PARENT
        ));

        addView(previewView);

        return previewView;
    }
}
