## 2.0.1

Android: Samsung Galaxy S22 - adding support

## 2.0.0

###Android Breaking changes in 2.x

<s>`sprenRef.current?.setAutoStart(boolean);`</s> (Replace with `sprenRef.current?.reset()` method)

<s>`sprenRef.current?.setTorchMode(boolean)`</s> (Replace with `sprenRef.current?.turnFlashOn()`)

<s>`sprenRef.current?.dropComplexity()`</s> (no need to handle anymore)

<s>`sprenRef.current?.handleOverExposure()`</s> (no need to handle anymore)


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
