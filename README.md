![Spren logo](spren.svg)


[![Github All Releases](https://img.shields.io/github/downloads/Elite-HRV/react-native-check-app-install/total.svg)]()

The `Spren SDK` is offering our customers a set of tools for measuring and analyzing stress, recovery and other markers of wellbeing.

It is designed for wide usage where you will be able to use the SDK to create your custom cutting edge applications.


**Installation**
---

- Install `Spren SDK` with `Xcode`
   + Open `File` &#8594; `Swift Packages` &#8594; `Add Package Dependency`
   + Put `https://github.com/Elite-HRV/spren-ios-package` in the searchbar
   + Use the `latest` version defaulted to you

The `UI/UX` aren't comprised in `SDK`, therefore there are many ways how to use the `SDK`.
We've built few use cases in order you to get wider imagination of the way how `SDK` can leverage your business needs.

**Usage** `ARKit`
---
Source code example can be found here - https://github.com/Elite-HRV/eliteapp
You fill find references to this repository items below:

Here are the main highlights:

- [Info.plist](https://www.google.com/CameraController)
    - Add `Privacy - Camera Usage Description` with the description best feeds your needs:
      ex: "Camera feed is used for tracking your biomarkers"
- Add your custom [UIViewController](https://www.google.com/CameraController).
    - [Import]() and [initiate]() `Spren` library
- Add animations using `ARKit` by implementing [ARSCNViewDelegate]()
- Implement [ARSessionDelegate]()
    - Implement [session(_ session: ARSession, didUpdate frame: ARFrame)]()
    - Send captured frames to `Spren` using [spren.capture(pixelBuffer: frame.capturedImage)]()
- Implement [SprenDelegate]()
    - Reference delegate [spren.delegate = self]()
    - [Receive]() biometric data
    - Reflect biometric data on the screen

**Usage** `AVFoundation`
---
Source code example can be found here - https://github.com/Elite-HRV/eliteapp/tree/project/elite-scanner
You fill find references to this repository items below:

Here are the main highlights:

- [Info.plist](https://www.google.com/CameraController)
    - Add `Privacy - Camera Usage Description` with the description best feeds your needs:
        ex: "Camera feed is used for tracking your biomarkers"
- Add your custom [UIViewController](https://www.google.com/CameraController).
    - [Import]() and [initiate]() `Spren` library
    - [Setup and initiating]() front camera
    - Set camera `frame per second` [FPS](https://www.google.com/CameraController) value to 30.
- Implement [AVCaptureVideoDataOutputSampleBufferDelegate]()
    - Send captured frames to `Spren` using [spren.capture(sampleBuffer: sampleBuffer)]() method
- Implement [SprenDelegate]()
    - Reference delegate [spren.delegate = self]()
    - [Receive]() biometric data
    - Reflect biometric data on the screen