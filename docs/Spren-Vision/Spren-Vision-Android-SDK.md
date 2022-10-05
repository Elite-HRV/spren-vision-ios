# Spren Vision Android SDK

The Android SDK is in Alpha. We're working quickly to expand our support in the heterogeneity of Android devices. 

## Device Support and Recommendations

> A supported device function exposed by the SDK is coming soon!

## Tested Devices
* Google Pixel 3XL
* Google Pixel 4
* Google Pixel 4a
* Google Pixel 5
* Xiaomi Redmi 9
* Huawei Mate 20
* Samsung Galaxy S10+

## Currently Testing
* Samsung Galaxy S9, S10 5G, S20 FE 5G, S21 Ultra, and S22+

## Recommendations

### Flash

Currently, we allow users to only perform readings with flash on.

### Hardware

1. We recommend using an Android device that is not a low RAM device, has at least 8 cores, and has 192MB or more RAM available to your app. 
    ```kotlin
    val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
    val isHighPerformingDevice = !activityManager.isLowRamDevice && 
        Runtime.getRuntime().availableProcessors() >= 8 && 
        activityManager.memoryClass >= 192
    ```
2. 30FPS is acceptable, but for best accuracy and UX, we recommend devices that support 60FPS in CameraX. Note that 60FPS or better may be listed in manufacturer's device specifications, thus, be supported in the native camera app, but be unavailable to CameraX.


## Installation

1.  Visit the [Spren Vision Android SDK Maven Repository](https://search.maven.org/search?q=com.spren) to install the SDK via the Gradle build tool. We encourage using the latest remote binary available. For more information, see the Android docs for [Add build dependencies](https://developer.android.com/studio/build/dependencies).

2.  Add a camera usage permission to your app's Manifest. For more information, [Request app permissions](https://developer.android.com/training/permissions/requesting).

The open source code is available in the [Spren Vision Android SDK GitHub Repository](https://github.com/Elite-HRV/spren-vision-android).

## Spren UI

### Implementation Example

```kotlin
// MainActivity.kt

import com.spren.sprenui.SprenUI

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // optionally set custom theme
        // theme inherits from "Theme.MaterialComponents.DayNight.NoActionBar"
        // see themes.xml example below
        setTheme(R.style.Theme_SprenUI)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        // set user ID
        SprenUI.Config.userId = ...
        
        // optionally set user biological sex
        SprenUI.Config.userGender = ...

        // optionally set user birthdate
        SprenUI.Config.userBirthdate = ...

        // after dismissing results screen
        SprenUI.Config.onFinish =
            { guid,
              hr,
              hrvScore,
              rmssd,
              breathingRate,
              readiness,
              ansBalance,
              signalQuality ->
            
              // handle completion of reading UI flow
            }
        

        // user presses X
        SprenUI.Config.onCancel = { 
          // handle user exit of UI flow without completing a reading
        }
    }
}
```

```xml
<!-- activity_main.xml corresponding to MainActivity.kt -->

<?xml version="1.0" encoding="utf-8"?>
<com.spren.sprenui.SprenUI xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    app:api_key="@string/api_key" 
    app:base_url="@string/base_url"
    tools:context=".MainActivity" />
```

```xml
<!-- themes.xml -->

<resources xmlns:tools="http://schemas.android.com/tools">
    <style name="AppTheme.Base" parent="Theme.MaterialComponents.DayNight.NoActionBar">
        <!-- button color --> 
        <item name="colorPrimary">#6200EE</item> 

        <!-- button text color -->
        <item name="colorOnPrimary">@android:color/white</item> 
        
        <!-- graphics color -->
        <item name="colorSecondary">#03DAC5</item> 
    </style>
</resources>
```

## SprenCapture and SprenCore

### Implementation Example

Here is an example of how to implement the Spren Vision Android SDK in your own app. Refer to the comments throughout the file to see what functions get called at what point.

```kotlin
import com.spren.sprencapture.SprenCapture
import com.spren.sprencore.*
import com.spren.sprencore.finger.compliance.ComplianceCheck
import com.spren.sprencore.event.SprenEvent
import com.spren.sprencore.event.SprenEventManager

/* SprenCapture */
// configure camera and set up camera preview
sprenCapture =
    SprenCapture(activity, previewView.surfaceProvider)
sprenCapture?.start()

/* SprenCore */

// handle state transitions
private fun stateListener(values: HashMap<String, Any>) {
    when (values["state"]) {
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
            // handle error UI update
            errorState()
            // call sprenCapture reset when the app is ready to start a new reading
    }
}
// Subscribe to state events
SprenEventManager.subscribe(SprenEvent.STATE, ::stateListener)
// Unsubscribe when leaving the flow
SprenEventManager.unsubscribe(SprenEvent.STATE, ::stateListener)

// handle prereading compliance checks
private fun complianceListener(values: HashMap<String, Any>) {
    val name = values["name"] as ComplianceCheck.Name
    val compliant = values["isCompliant"] as Boolean

    when (name) {
        ComplianceCheck.Name.LENS_COVERAGE ->
            // optionally update UI to reflect lens coverage compliance
            handleLensCoverageCompliance(
                name,
                compliant,
            )

        ComplianceCheck.Name.EXPOSURE ->
            // optionally update UI to reflect exposure compliance
            handleExposureCompliance(
                name,
                compliant,
            )
    }
}
// Subscribe to compliance events
SprenEventManager.subscribe(SprenEvent.COMPLIANCE, ::complianceListener)
// Unsubscribe when leaving the flow
SprenEventManager.unsubscribe(SprenEvent.COMPLIANCE, ::complianceListener)

// handle progress changes
private fun progressListener(values: HashMap<String, Any>){
    // handle progress UI update
    val progress = values["progress"] as Int
    updateProgress(progress)
}
// Subscribe to progress events
SprenEventManager.subscribe(SprenEvent.PROGRESS, ::progressListener)
// Unsubscribe when leaving the flow
SprenEventManager.unsubscribe(SprenEvent.PROGRESS, ::progressListener)
```

#### Breaking changes in 2.x

##### `SprenCapture`
<s>`var autoStart = true`</s> (Replace with `SprenCapture reset` method)

Enable or disable reading autostart. Autostart occurs after 3 seconds of conditions checks compliance.

##### `Spren`
<s>`fun setTorchMode(torch: Boolean): Boolean`</s> (Replace with `fun turnFlashOn()`)

Attempts to toggle the torch (flashlight) on as appropriate. Returns the resulting torch mode. Setting the flash off has been disabled.

<s>`fun dropComplexity(): Boolean`</s> (no need to handle anymore)

This function has been deprecated and will be removed in the next releases.

<s>`fun handleOverExposure()`</s> (no need to handle anymore)

Attempts to reduce the exposure of the image by lowering the sensor exposure time. This may be called if exposure is non-compliant, i.e, at least 5 frames are over-exposed.


## SprenCapture Library

SprenCapture is where you can initialize a camera preview and first configure the camera. This will start a camera preview and image analysis, allow you to add the camera preview to your UI, and handle various other camera controls. Check out the function definitions below!

#### `SprenCapture`

`fun start(): Boolean`

Attempts to create a Preview and ImageAnalysis use cases. Returns false when the camera does not support at least 30 FPS. For more information, see the Android docs for [CameraX overview](https://developer.android.com/training/camerax).

`fun stop()`

Stops the Preview and ImageAnalysis use cases

`fun reset()`

Starts or restarts a reading.
Reading will start after 3 seconds of conditions checks compliance.
This function needs to be called after `fun start(): Boolean` method and after subscribing to Spren Events 

`fun turnFlashOn()`

Attempts to toggle the torch (flashlight) on.

#### `RGBAnalyzer`

RGBAnalyzer is an `ImageAnalysis.Analyzer` and handles providing frames to **SprenCore**.

## SprenCore Library

The SprenCore library provides internal control over readings and allows you to gain information on what's going on internally in the SDK so your UI can be updated accordingly. Here you'll be able to set reading durations, handle progress updates, start and stop readings, and more. Use this library in conjunction with **SprenCapture** to utilize the full capabilities of Spren SDK.

#### `SprenEventManager` subscribe
`SprenEventManager.subscribe(SprenEvent.STATE, ::stateListener)`

Subscribes to events when state changes occur, i.e., *started*, *finished*, *cancelled*, and *error*.
>`fun stateListener(values: HashMap<String, Any>)`
>> HashMap  **key**: value
>> * **state**:  SprenState

`SprenEventManager.subscribe(SprenEvent.COMPLIANCE, ::complianceListener)`

Subscribes to events when a compliance check is performed. Compliance checks for lens coverage, and exposure are performed once per second.
>`fun complianceListener(values: HashMap<String, Any>)`
>> HashMap  **key**: value
>> * **name**:  ComplianceCheck.Name
>> * **isCompliant**:  Boolean


`SprenEventManager.subscribe(SprenEvent.PROGRESS, ::progressListener)`

Subscribes to events when progress updates. Progress ranges from 0 to 99 in integer increments. State change to finished occurs in lieu of progress update at 100.
>`fun progressListener(values: HashMap<String, Any>)`
>> HashMap  **key**: value
>> * **progress**:  Int

#### `SprenEventManager` unsubscribe
Unsubscribing events before leaving the flow
```
SprenEventManager.unsubscribe(SprenEvent.STATE, ::stateListener)
SprenEventManager.unsubscribe(SprenEvent.COMPLIANCE, ::complianceListener)
SprenEventManager.unsubscribe(SprenEvent.PROGRESS, ::progressListener)
```

#### `Spren`

`fun Spren.Companion.startReading()`

Manually start the reading.

`fun Spren.Companion.cancelReading()`

Manually stop the reading.

`fun getReadingData(context: Context): String?`

After Spren transitions to finished, reading data may be retrieved to hit the Spren API for results. See the [**User and SDK data**](https://docs.spren.com/user-and-sdk-data) **POST** endpoint for more information.

`var readingDurationSeconds = 90`

Reading duration ≥ 90 seconds or ≤ 240 seconds.

`fun Spren.Companion.setReadingDuration(duration: Int)`

Set the reading duration. A duration in the range ≥ 90 seconds or ≤ 240 seconds must be provided or the call returns.


#### If not using SprenCapture

If you'd like to use your own library or code to handle camera configurations and initialization, make sure to reference this section and the **RGBAnalyzer** section to get more context and see what functions need to be implemented.

Reference `RGBAnalyzer`

`fun process(frame: Bitmap, timestamp: Long)`

Provide a frame for processing.

`Bitmap`

Created from ImageProxy e.g.:

`val bitmap = imageProxy.image!!.toBitmap()`

The ImageProxy format will be PixelFormat.RGBA_8888, which has only one image plane (R, G, B, A pixel by pixel). For more information, [Image Analysis](https://developer.android.com/training/camerax/analyze).

### Compliance Checks

#### `ComplianceCheck`

Compliance checks are run at 1 second intervals as frames are provided, i.e., if internally to SprenCore the time when the frame is received is >1 second later than the last check. For `ComplianceCheck.Name`:

*   `LENS_COVERAGE`: finger must cover lens with light pressure.

*   `EXPOSURE`: less than 30 frames must have overexposure. A frame is over-exposed when it appears brighter than it should.

