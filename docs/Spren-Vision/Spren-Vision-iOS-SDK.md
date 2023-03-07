# Spren Vision iOS SDK

## Installation

1.  Visit the [Spren Vision iOS SDK GitHub Repository](https://github.com/Elite-HRV/spren-vision-ios) to install the SDK via the Swift Package Manager. For more information, see the Apple docs for [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).

2.  Add a camera usage description to your app's Info.plist or target info. For more information, [Requesting Authorization for Media Capture on iOS](https://developer.apple.com/documentation/avfoundation/cameras_and_media_capture/requesting_authorization_for_media_capture_on_ios) and the [NSCameraUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nscamerausagedescription) Apple docs.

## Spren UI

### Implementation Example

```swift
import SwiftUI
import SprenUI

// create SprenUI configuration
let config = SprenUI.Config(
    // API
    baseURL: "https://test.api.spren.com",
    apiKey: "<API key>",

    // user
    userID: "<user ID>",
    userGender: <optional, male, female, or other>,
    userBirthdate: <optional, Date>,

    // UI
    primaryColor:   <optional, Color>, // used for buttons
    secondaryColor: <optional, Color>, // used for graphics

    project: .fingerCamera,

    // optionally override default intro screen graphics
    // provide names for image sets in main bundle xcassets
    // *all are required for each project if overriding
    graphics: [
        .greeting1:      "<image set name>", // greeting screen 1
        .greeting2:      "<image set name>", // greeting screen 2
        .fingerOnCamera: "<image set name>", // finger on camera instruction screen
        .noCamera:       "<image set name>", // camera access authorization denied screen
        .serverError:    "<image set name>"  // server or calculation error
    ],

    onCancel: {
        // user exited UI before completing a reading
        // dismiss SprenUI
    },
    onFinish: { results in
        // user completed a reading!
        print(results)
        // dismiss SprenUI
    }
)

// init SprenUI view
SprenUI(config: config)

```

## SprenCapture and SprenCore

### Implementation Example

```swift
import SprenCapture
import SprenCore

...

/* SprenCapture */
// configure camera
let sprenCapture = SprenCapture()
try? SprenCapture.start()
// set up camera preview
preview.session = sprenCapture.session

/* SprenCore */

// handle prereading compliance checks
Spren.setOnPrereadingComplianceCheck { check, compliant, action in
    switch (check, compliant) {
    case (.frameDrop, false):
		// adjust camera
        sprenCapture.dropComplexity()
    case (.brightness, _):
        // optionally update UI to reflect brightness compliance
    case (.lensCoverage,_):
		// optionally update UI to reflect lens coverage compliance
    }
}

// handle state transitions
Spren.setOnStateChange { (state, error) in
		switch state {
	  case .started:
			sprenCapture.lock()
		    // handle reading started UI update

	  case .finished:
		    // successful reading!
		    let readingData = Spren.getReadingData()

		    // make POST request to the Spren API
		    // with readingData to get insights!

	  case .cancelled:
			sprenCapture.unlock()
		    // handle user cancelled UI update

	  case .error:
			sprenCapture.unlock()
		    // handle error UI update, may be non-compliance
		    let description = error.localizedDescription
	  }
}

Spren.setOnProgressUpdate { (progress) in
    // handle progress UI update
}
```

## SprenCapture Library

SprenCapture is where you can initialize a camera preview and first configure the camera. This will start a camera session, allow you to add the camera preview to your UI, and handle various other camera controls. Check out the function definitions below!

#### `SprenCapture`

`session: AVCaptureSession`

AVCaptureSession exposed for UI preview.

`init() throws`

Sets up AVCapture session inputs and outputs with the rear wide angle camera.

`func start()`

Starts running the underlying AVCapture session.

`func stop()`

Stops running the AVCapture session.

`func toggleTorch() throws -> AVCaptureDevice.TorchMode`

Attempts to toggle the torch (flashlight) on. Returns the resulting torch mode.

`func lock() throws`

Attempts to lock automatic camera settings. This should be called when a reading starts.

`func unlock() throws`

Attempts to unlock automatic settings. This should be called if autostart will reoccur, i.e., when a reading is cancelled or errors.

`func dropComplexity() throws → Bool`

Attempts to drop the computational complexity by reducing the frame rate. If frame rate cannot be reduced, dropping the resolution will be attempted. This may be called if frame drop is non-compliant, i.e, exceeds 5% in a 1 second period.

#### `SprenDelegate`

SprenDelegate is an `AVCaptureVideoDataOutputSampleBufferDelegate` and handles providing frames or notification of frame drop to **SprenCore**.

## SprenCore Library

The SprenCore library provides internal control over readings and allows you to gain information on what's going on internally in the SDK so your UI can be updated accordingly. Here you'll be able to set reading durations, handle progress updates, start and stop readings, and more. Use this library in conjunction with **SprenCapture** to utilize the full capabilities of Spren SDK.

#### `Spren`

`static autoStart: Bool`

Enable or disable reading autostart. Autostart occurs after 3 seconds of conditions checks compliance.

`static internal(set) var readingDurationSeconds: Double`

Reading duration ≥ 60 seconds or ≤ 240 seconds.

`static func setReadingDuration(duration: Int)`

Set the reading duration. A duration in the range ≥ 60 seconds or ≤ 240 seconds must be provided or the call returns.

`static func setOnPrereadingComplianceCheck(onPrereadingComplianceCheck: @escaping (ComplianceCheck.Name, Bool, ComplianceCheck.Action?) -> Void)`

Set a closure to be executed when a compliance check is performed before reading start. Compliance checks for frame drop, brightness, and lens coverage are performed once per second.

`static setOnProgressUpdate(onProgressUpdate: @escaping (_ progress: Double) -> Void)`

Set a closure to be executed when progress updates. Progress ranges from 0 to 99 in integer increments. State change to finished occurs in lieu of progress update at 100.

`static func setOnStateChange(onStateChange: @escaping (_ state: SprenState, _ error: Error?) -> Void)`

Set a closure to be executed when state changes occur, i.e., _started_, _finished_, _cancelled_, and _error_.

`static func startReading()`

Manually start the reading.

`static func cancelReading()`

Manually stop the reading.

`static func getReadingData() -> String?`

After Spren transitions to finished, reading data may be retrieved to hit the Spren API for results. See the [**User and SDK data**](https://docs.spren.com/user-and-sdk-data) **POST** endpoint for more information.

#### If not using SprenCapture

If you'd like to use your own library or code to handle camera configurations and initialization, make sure to reference this section and the **SprenDelegate **section to get more context and see what functions need to be implemented.

Reference `SprenDelegate`

`static func process(frame: SprenFrame)`

Provide a frame for processing.

`static func frameDropped()`

Record frame drop.

`SprenFrame`

Created from received media buffers, e.g.:

`SprenFrame(sampleBuffer: sampleBuffer, orientation: connection.videoOrientation.rawValue)`

### Compliance Checks

#### `ComplianceCheck`

`static func setOnPrereadingComplianceCheck(onPrereadingComplianceCheck: @escaping (ComplianceCheck.Name, Bool, ComplianceCheck.Action?) -> Void)`

Compliance checks are run at 1 second intervals as frames are provided, i.e., if internally to SprenCore the time when the frame is received is >1 second later than the last check. For `ComplianceCheck.name`:

- `.frameDrop`: frame drop must be less than 5% during one second and at least 60 frames must be received. During the initial setup of SprenCapture, frame drop may be high; **so, we suggest ignoring the first frame drop noncompliance** before any camera reconfiguration.

- `.brightness`: enough ambient light must be received, torch (flashlight) is recommended. Brightness checks also provide a `ComplianceCheck.action`, either `.increase` or `.decrease`.

- `.lensCoverage`: finger must cover lens with light pressure.

#### `SprenComplianceError`

`static func setOnStateChange(onStateChange: @escaping (_ state: SprenState, _ error: Error?) -> Void)`

Readings error if noncompliance of any check occurs for 5 consecutive seconds. If this occurs, re-enable autostart to start the compliance check and reading process over again.

- `.frameDropHigh`

- `.brightnessLow`

- `.brightnessHigh`

- `.lensCoverage`
