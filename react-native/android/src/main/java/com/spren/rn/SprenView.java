package com.spren.rn;

import android.view.LayoutInflater;
import android.view.View;
import android.widget.FrameLayout;
import androidx.annotation.NonNull;
import androidx.camera.view.PreviewView;
import androidx .appcompat.app.AppCompatActivity;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.uimanager.ThemedReactContext;
import com.spren.rn.events.SprenEvents;
import com.spren.sprencapture.SprenCapture;
import com.spren.sprencore.Spren;
import com.spren.sprencore.SprenState;
import com.spren.sprencore.Spren_PublicConfigKt;
import com.spren.sprencore.finger.compliance.ComplianceCheck;
import com.spren.sprencore.finger.compliance.SprenComplianceError;
import org.jetbrains.annotations.Nullable;
import java.util.Objects;
import kotlin.Unit;
import kotlin.jvm.functions.Function1;
import kotlin.jvm.functions.Function2;
import kotlin.jvm.functions.Function3;

public class SprenView extends FrameLayout {
    SprenCapture sprenCapture;
    ThemedReactContext context;
    CoordinatorLayout container;
    CoordinatorLayout children;
    SprenViewCommands sprenViewCommands;

    public SprenView(@NonNull ThemedReactContext context) {
        super(context);
        this.context = context;

        PreviewView previewView = setupViews();
        sprenCapture = new SprenCapture((AppCompatActivity) Objects.requireNonNull(context.getReactApplicationContext().getCurrentActivity()), previewView);
        sprenViewCommands = new SprenViewCommands(sprenCapture, this);
        setSprenCallbacks();
        startSpren(previewView);
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

    @Override
    protected void onDetachedFromWindow() {
        sprenCapture.stop();
        super.onDetachedFromWindow();
    }

    public void receiveCommand(String command, @androidx.annotation.Nullable ReadableArray args) {
        sprenViewCommands.receiveCommand(command, args);
    }

    private void setSprenCallbacks() {
        SprenView that = this;
        Spren_PublicConfigKt.setOnStateChange(Spren.Companion, (sprenState, sprenComplianceError) -> {
            SprenEvents.emitStateChangeEvent(that, sprenState, sprenComplianceError);
            return null;
        });
        Spren_PublicConfigKt.setOnPrereadingComplianceCheck(Spren.Companion, (name, aBoolean, action) -> {
            SprenEvents.emitPrereadingComplianceCheckEvent(that, name, aBoolean, action);
            return null;
        });
        Spren_PublicConfigKt.setOnProgressUpdate(Spren.Companion, (progress) -> {
            SprenEvents.emitProgressUpdateEvent(that, progress);
            return null;
        });
    }

    /**
     * Start Spren camera
     * @param camera preview view
     */
    private void startSpren(PreviewView previewView) {
        sprenCapture.start();
        installHierarchyFitter(previewView);
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

    /**
     * Android native UI components are not re-layout on dynamically added views
     * This method needs to be called when using PreviewView. When using TextureView there is no necessity
     * https://github.com/facebook/react-native/issues/17968
     */
    private void installHierarchyFitter(PreviewView view) {
        view.setOnHierarchyChangeListener(new OnHierarchyChangeListener() {
            @Override
            public void onChildViewRemoved(@Nullable View parent, @Nullable View child) { }

            @Override
            public void onChildViewAdded(@Nullable View parent, @Nullable View child) {
                if (parent != null) {
                    parent.measure(
                        MeasureSpec.makeMeasureSpec(parent.getMeasuredWidth(), MeasureSpec.EXACTLY),
                        MeasureSpec.makeMeasureSpec(parent.getMeasuredHeight(), MeasureSpec.EXACTLY)
                    );
                }
                if (parent != null) {
                    parent.layout(0, 0, parent.getMeasuredWidth(), parent.getMeasuredHeight());
                }
            }
        });
    }
}
