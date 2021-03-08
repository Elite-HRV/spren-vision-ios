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

**Usage**
---
1. Info.plist
    - Add `Privacy - Camera Usage Description` with the description best feeds your needs:
      ex: "Camera feed is used for tracking your biomarkers"
2. Create a `Storyboard`
    - Add `UIViewController`
    - Add `UIView`
        - Specify `Custom Class` inside `identity inspector`
        - Set `Class` to `SprenCameraView`
        - Set `Module` to `spren`
3. Reference `UIView` as `@IBOutlet` inside `UIViewController`
    - Start the reading by calling `startReading` of `UIView` inside `UIViewController`
       ```
       Usage: startReading
       Params: readingLength (seconds)
       Callback: hr (float), hrv (float), bpm (float). Callaback is called every two seconds.
 
       Example:
       public override func viewWillAppear(_ animated: Bool) {
          self.cameraView.startReading(readingLength: 60) { (hr, hrv, bpm) -> () in
             print(hr, hrv, bpm)
          }
       }
       ```
    - Exit the reading by calling `exitReading` of `UIView` inside `UIViewController`
       ```
       Usage: exitReading
       Example:
       public override func viewWillDisappear(_ animated: Bool) {
          self.cameraView.exitReading()
       }
       ```
      **Important!**
      _Exit reading is obligatory in order to free camera resources_
4. Add any other UI styles changes you need.

**Demo App**
---
The `UI/UX` flows aren't comprised in `SDK`, therefore there are many ways how to use the `SDK`.
We've built few demo `UI/UX` flows in order you to get wider imagination of the way how `SDK` can leverage your business needs.

You can find the app here - https://github.com/Elite-HRV/spren-ios-demo
