![Spren logo](spren.svg)


[![Github All Releases](https://img.shields.io/github/downloads/Elite-HRV/spren-ios-sdk/total.svg)]()

The `Spren SDK` is offering our customers a set of tools for measuring and analyzing stress, recovery and other markers of wellbeing.

It is designed for wide usage where you will be able to use the SDK to create your custom cutting edge applications.


**Installation**
---

- Install `Spren SDK` with `Xcode`
   + Open `File` &#8594; `Swift Packages` &#8594; `Add Package Dependency`
   + Put `https://github.com/Elite-HRV/spren-ios-sdk` in the searchbar
   + Use the `latest` version defaulted to you

The `UI/UX` aren't comprised in `SDK`, therefore there are many ways how to use the `SDK`.
We've built few use cases in order you to get wider imagination of the way how `SDK` can leverage your business needs.

**Usage** `ARKit`
---
Source code example can be found here - https://github.com/Elite-HRV/spren-ios-demo
You fill find references to this repository items below:

Here are the main highlights:

- [Info.plist](https://github.com/Elite-HRV/spren-ios-demo/blob/05a48441a9003d113555b3267268e37ea12436e5/EHRV/Info.plist)
    - Add `Privacy - Camera Usage Description` with the description best feeds your needs:
      ex: "Camera feed is used for tracking your biomarkers"
- Add your custom [UIViewController](https://github.com/Elite-HRV/spren-ios-demo/blob/05a48441a9003d113555b3267268e37ea12436e5/EHRV/Views/AR/ARViewController.swift).
    - [Import](https://github.com/Elite-HRV/spren-ios-demo/blob/05a48441a9003d113555b3267268e37ea12436e5/EHRV/Views/AR/ARViewController.swift#L11) and [initiate](https://github.com/Elite-HRV/spren-ios-demo/blob/05a48441a9003d113555b3267268e37ea12436e5/EHRV/Views/AR/ARViewController.swift#L16) `Spren` library
- Add animations using `ARKit` by implementing [ARSCNViewDelegate](https://github.com/Elite-HRV/spren-ios-demo/blob/05a48441a9003d113555b3267268e37ea12436e5/EHRV/Views/AR/ARViewController.swift#L13)
- Implement [ARSessionDelegate](https://github.com/Elite-HRV/spren-ios-demo/blob/05a48441a9003d113555b3267268e37ea12436e5/EHRV/Views/AR/ARViewController.swift#L13)
    - Implement [session(_ session: ARSession, didUpdate frame: ARFrame)](https://github.com/Elite-HRV/spren-ios-demo/blob/05a48441a9003d113555b3267268e37ea12436e5/EHRV/Views/AR/ARViewController.swift#L134)
    - Send captured frames to `Spren` using [spren.capture(pixelBuffer: frame.capturedImage)](https://github.com/Elite-HRV/spren-ios-demo/blob/05a48441a9003d113555b3267268e37ea12436e5/EHRV/Views/AR/ARViewController.swift#L135)
- Implement [SprenDelegate](https://github.com/Elite-HRV/spren-ios-demo/blob/05a48441a9003d113555b3267268e37ea12436e5/EHRV/Views/EHRCustomGraphView%2BSprenDelegate.swift#L11)
    - Reference delegate [spren.delegate = self](https://github.com/Elite-HRV/spren-ios-demo/blob/05a48441a9003d113555b3267268e37ea12436e5/EHRV/Views/EHRCustomGraphView.swift#L39)
    - [Receive](https://github.com/Elite-HRV/spren-ios-demo/blob/05a48441a9003d113555b3267268e37ea12436e5/EHRV/Views/EHRCustomGraphView%2BSprenDelegate.swift#L12-#L20) biometric data
    - Reflect biometric data on the screen

**Usage** `AVFoundation`
---
Source code example can be found here - https://github.com/Elite-HRV/spren-ios-demo/tree/AVFoundation
You fill find references to this repository items below:

Here are the main highlights:

- [Info.plist](https://github.com/Elite-HRV/spren-ios-demo/blob/f4ce21578d28307db7b0504cb393f876142a014e/iOS/Info.plist)
    - Add `Privacy - Camera Usage Description` with the description best feeds your needs:
        ex: "Camera feed is used for tracking your biomarkers"
- Add your custom [UIViewController](https://github.com/Elite-HRV/spren-ios-demo/blob/f4ce21578d28307db7b0504cb393f876142a014e/Shared/CameraController.swift).
    - [Import](https://github.com/Elite-HRV/spren-ios-demo/blob/f4ce21578d28307db7b0504cb393f876142a014e/Shared/CameraController.swift#L10) and [initiate](https://github.com/Elite-HRV/spren-ios-demo/blob/f4ce21578d28307db7b0504cb393f876142a014e/Shared/CameraController.swift#L14) `Spren` library
    - [Setup and initiating](https://github.com/Elite-HRV/spren-ios-demo/blob/f4ce21578d28307db7b0504cb393f876142a014e/Shared/CameraController.swift#L36-#L40) front camera
    - Set camera `frame per second` [FPS](https://github.com/Elite-HRV/spren-ios-demo/blob/f4ce21578d28307db7b0504cb393f876142a014e/Shared/CameraController.swift#L13) value to 30.
- Implement [AVCaptureVideoDataOutputSampleBufferDelegate](https://github.com/Elite-HRV/spren-ios-demo/blob/f4ce21578d28307db7b0504cb393f876142a014e/Shared/CameraController%2BAVCaptureVideoDataOutputSampleBufferDelegate.swift#L10)
    - Send captured frames to `Spren` using [spren.capture(sampleBuffer: sampleBuffer)](https://github.com/Elite-HRV/spren-ios-demo/blob/f4ce21578d28307db7b0504cb393f876142a014e/Shared/CameraController%2BAVCaptureVideoDataOutputSampleBufferDelegate.swift#L12) method
- Implement [SprenDelegate](https://github.com/Elite-HRV/spren-ios-demo/blob/f4ce21578d28307db7b0504cb393f876142a014e/Shared/CameraController%2BSprenDelegate.swift#L10)
    - Reference delegate [spren.delegate = self](https://github.com/Elite-HRV/spren-ios-demo/blob/f4ce21578d28307db7b0504cb393f876142a014e/Shared/CameraController.swift#L27)
    - [Receive](https://github.com/Elite-HRV/spren-ios-demo/blob/AVFoundation/Shared/CameraController%2BSprenDelegate.swift#L11-#L19) biometric data
    - Reflect biometric data on the screen