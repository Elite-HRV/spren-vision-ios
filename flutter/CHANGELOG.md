## 2.0.2

Android: Fixed MissingPluginException error

## 2.0.1

Updated LICENSE file

## 2.0.0

###Android Breaking changes in 2.x

<s>`SprenFlutter.setAutoStart(Boolean);`</s> (Replace with `SprenFlutter.reset()` method)

<s>`SprenFlutter.setTorchMode(Boolean)`</s> (Replace with `SprenFlutter.turnFlashOn()`)

<s>`SprenFlutter.dropComplexity()`</s> (no need to handle anymore)

<s>`SprenFlutter.handleOverExposure()`</s> (no need to handle anymore)


###iOS Breaking changes in 2.x

None

####All the breaking changes are handled in example app (check it for more details)


------
Android: Add SprenCapture reset method

Android: Add SprenCapture turnFlashOn method

Android: Fix lens coverage bug

Example App: Add unsupportiveness notice for Android 8 or lower devices

Example App: Cancel reading when device enter background mode

Example App: Result screen when pressing back button or user swipes back -> navigates to home screen 

Add new license (see LICENSE.pdf)

## 1.3.0

Android: - Adding support for more Android devices
https://docs.spren.com/spren-vision/spren-vision-android-sdk

## 1.2.3

Android: - Add ability to call Spren methods asynchronously using `await` 
Android: - Set `Measurement complete` text in the end of the reading 

## 1.2.2

Android: Fixing bug https://github.com/Elite-HRV/spren-vision-ios/issues/9

## 1.2.1

Android: Added Pixel 5 support:

    - com.spren.sprencapture:1.1.0

## 1.2.0

iOS: updated SprenVision 1.2.0 dependency
Android: Added alpha dependencies:

    - com.spren.sprencore:1.0.0
    - com.spren.sprencapture:1.0.0

## 1.1.0

Added 60s reading length support
Added preliminary Android support

## 1.0.1

Fixed minor path issue

## 1.0.0

Spren flutter plugin
