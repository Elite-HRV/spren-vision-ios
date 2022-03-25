# Spren Vision Android SDK

## Installation

1.  Visit the [Spren Vision Android SDK GitHub Repository](https://github.com/Elite-HRV/spren-vision-android) to install the SDK via the Gradle build system. For more information, see the Android docs for [Add build dependencies](https://developer.android.com/studio/build/dependencies).

2.  Add a camera usage permission to your app's Manifest. For more information, [Request app permissions](https://developer.android.com/training/permissions/requesting).

## Implementation Overview

Here is an example of how to implement the Spren Vision Android SDK in your own app. Refer to the comments throughout the file to see what functions get called at what point.

```kotlin
import com.spren.sprencapture.SprenCapture
import com.spren.sprencore.*
import com.spren.sprencore.finger.compliance.ComplianceCheck

/* SprenCapture */
// configure camera set up camera preview
sprenCapture =
    SprenCapture(activity, previewView)
sprenCapture?.start()

/* SprenCore */

// handle prereading compliance checks
Spren.setOnPrereadingComplianceCheck { name, compliant, action ->

    when (name) {
        ComplianceCheck.Name.FRAME_DROP ->
            // adjust camera
            handleFrameDropCompliance(
                name,
                compliant,
                action
            )

        ComplianceCheck.Name.BRIGHTNESS ->
            // optionally update UI to reflect brightness compliance
            handleBrightnessCompliance(
                name,
                compliant,
                action
            )

        ComplianceCheck.Name.LENS_COVERAGE ->
            // optionally update UI to reflect lens coverage compliance
            handleLensCoverageCompliance(
                name,
                compliant,
                action
            )
    }
}

// handle state transitions
Spren.setOnStateChange { state, _ ->
    when (state) {
        SprenState.STARTED ->
            // handle reading started UI update
            startState()

        SprenState.FINISHED ->
            // successful reading!
            // make POST request to the Spren API
            // with readingData to get insights!
            finishState()

        SprenState.CANCELLED ->
            // handle user cancelled UI update
            cancelState()

        SprenState.ERROR ->
            // handle error UI update, may be non-compliance
            errorState()
    }
}

Spren.setOnProgressUpdate { progress ->
    // handle progress UI update
    updateProgress(progress)
}
```

# SprenCapture Library

SprenCapture is where you can initialize a camera preview and first configure the camera. This will start a camera preview and image analysis, allow you to add the camera preview to your UI, and handle various other camera controls. Check out the function definitions below!

### `SprenCapture`

`fun start()`

Creates a Preview and ImageAnalysis use cases. For more information, see the Android docs for [CameraX overview](https://developer.android.com/training/camerax).

`fun stop()`

Stops the Preview and ImageAnalysis use cases

`fun setTorchMode(torch: Boolean): Boolean`

Attempts to toggle the torch (flashlight) on or off as appropriate. Returns the resulting torch mode.

`fun dropComplexity(): Boolean`

Attempts to drop the computational complexity by reducing the frame rate. If frame rate cannot be reduced, dropping the resolution will be attempted. This may be called if frame drop is non-compliant, i.e, exceeds 5% in a 1 second period.

### `RGBAnalyzer`

RGBAnalyzer is an `ImageAnalysis.Analyzer` and handles providing frames to **SprenCore**.

# SprenCore Library

The SprenCore library provides internal control over readings and allows you to gain information on what's going on internally in the SDK so your UI can be updated accordingly. Here you'll be able to set reading durations, handle progress updates, start and stop readings, and more. Use this library in conjunction with **SprenCapture** to utilize the full capabilities of Spren SDK.

### `Spren`

`var autoStart = true`

Enable or disable reading autostart. Autostart occurs after 3 seconds of conditions checks compliance.

`var readingDurationSeconds = 90`

Reading duration ≥ 90 seconds or ≤ 240 seconds.

`fun Spren.Companion.setReadingDuration(duration: Int)`

Set the reading duration. A duration in the range ≥ 90 seconds or ≤ 240 seconds must be provided or the call returns.

`fun Spren.Companion.setOnPrereadingComplianceCheck(onPrereadingComplianceCheck: (ComplianceCheck.Name, Boolean, ComplianceCheck.Action?) -> Unit)`

Set a closure to be executed when a compliance check is performed before reading start. Compliance checks for frame drop, brightness, and lens coverage are performed once per second.

`fun Spren.Companion.setOnProgressUpdate(onProgressUpdate: (Int) -> Unit)`

Set a closure to be executed when progress updates. Progress ranges from 0 to 99 in integer increments. State change to finished occurs in lieu of progress update at 100.

`fun Spren.Companion.setOnStateChange(onStateChange: (ExternalStateMessage, SprenComplianceError?) -> Unit)`

Set a closure to be executed when state changes occur, i.e., *started*, *finished*, *cancelled*, and *error*.

`fun Spren.Companion.startReading()`

Manually start the reading.

`fun Spren.Companion.cancelReading()`

Manually stop the reading.

`fun getReadingData(context: Context): String?`

After Spren transitions to finished, reading data may be retrieved to hit the Spren API for results. See the [**User and SDK data**](https://docs.spren.com/user-and-sdk-data) **POST** endpoint for more information.

### If not using SprenCapture

If you'd like to use your own library or code to handle camera configurations and initialization, make sure to reference this section and the **RGBAnalyzer** section to get more context and see what functions need to be implemented.

Reference `RGBAnalyzer`

`override fun analyze(image: ImageProxy)`

Provide a frame for processing.

`ImageProxy`

An image proxy which has a similar interface as Image. For more information, see the Android docs for [ImageProxy](https://developer.android.com/reference/androidx/camera/core/ImageProxy).

## Compliance Checks

### `ComplianceCheck`

`fun Spren.Companion.setOnPrereadingComplianceCheck(onPrereadingComplianceCheck: (ComplianceCheck.Name, Boolean, ComplianceCheck.Action?) -> Unit)`

Compliance checks are run at 1 second intervals as frames are provided, i.e., if internally to SprenCore the time when the frame is received is >1 second later than the last check. For `ComplianceCheck.Name`:

*   `FRAME_DROP`: frame drop must be less than 5% during one second and at least 60 frames must be received. During the initial setup of SprenCapture, frame drop may be high; **so, we suggest ignoring the first frame drop noncompliance** before any camera reconfiguration.

*   `BRIGHTNESS`: enough ambient light must be received, torch (flashlight) is recommended. Brightness checks also provide a `ComplianceCheck.Action`, either `INCREASE` or `DECREASE`.

*   `LENS_COVERAGE`: finger must cover lens with light pressure.

### `SprenComplianceError`

`fun Spren.Companion.setOnStateChange(onStateChange: (ExternalStateMessage, SprenComplianceError?) -> Unit)`

Readings error if noncompliance of any check occurs for 5 consecutive seconds. If this occurs, re-enable autostart to start the compliance check and reading process over again.

*   `FRAME_DROP_HIGH`

*   `BRIGHTNESS_LOW`

*   `BRIGHTNESS_HIGH`

*   `LENS_COVERAGE`