# Introduction

## Spren Vision

The Spren Finger Camera SDK (**Spren Vision**) is a useful tool for companies that don't already have their own device to collect inter-beat intervals. A turnkey integration into your app with light UI/UX customization is only a few lines of code. For more customization, the open-source `SprenUI` library provides a complete example to integrate Spren.

## Know Before You Code

### Requirements

| **Item**            | **Requirement**                             |
| ------------------- | ------------------------------------------- |
| iOS Device          | iPhone 6s and iPhone SE (1st gen), or newer |
| iOS Version         | iOS 14+                                     |
| Android Version     | Android 9.0 (Pie) or newer                  |
| Android SDK Version | API 28+                                     |

### Cross-Platform UI Framework Support

| **Framework / Language** | **iOS SDK** | **Android SDK (Alpha)** | **URL** |
| ------------------------ | ----------- | ----------------------- | ------- |
| Flutter                  | Available   | Available               | https://pub.dev/packages/spren_flutter |
| React Native             | Available   | Available               | https://www.npmjs.com/package/@spren/react-native |

### 3 Components

Spren Vision has 3 components on Android and iOS.

1. The `SprenCore` binary framework - real-time video processing and finger-on-camera compliance checks to automatically start and stop a finger-on-camera reading and ensure its quality.
2. The `SprenCapture` library - camera configuration and video functionality wrapped around `SprenCore`.
3. The `SprenUI` library - a lightly-customizable, drop-in UI flow that uses the 2 prior components, `SprenCore` and `SprenCapture`, and communicates with Spren API to perform finger-on-camera biomarker extraction and insight generation. Feel free to fork!

## Getting Started

Check out our [Spren Vision iOS SDK](https://docs.spren.com/spren-vision/spren-vision-ios-sdk) or [Spren Vision Android SDK](https://docs.spren.com/spren-vision/spren-vision-android-sdk) pages for more information on installation, getting started, and code examples.