# Spren Plugin

[![pub package](https://img.shields.io/pub/v/spren_flutter.svg)](https://pub.dev/packages/spren_flutter)

A Flutter plugin for iOS allowing access Spren services.

|                | iOS     | Android     |
|----------------|---------|---------|
| **Support**    | iOS 14+*| API 28+|

## Features

* Records biological activity data.

## Installation

First, add `spren_flutter` as a [dependency in your pubspec.yaml file](https://flutter.dev/using-packages/).

### iOS

The spren_flutter plugin requires minimum deployment target set to iOS 14 or higher.

Add one row to the `ios/Runner/Info.plist`:

* one with the key `Privacy - Camera Usage Description` and a usage description.

If editing `Info.plist` as text, add:

```xml
<key>NSCameraUsageDescription</key>
<string>To measure your heart rate in order to provide you valuable insights.</string>
```

### API
```dart
import 'package:spren_flutter/spren_flutter.dart';
```

| Method                     | Parameters              | Description                                                                               |
|----------------------------|-------------------|-------------------------------------------------------------------------------------------|
| `await SprenFlutter.getReadingData()`        | `String`          | Returns reading data information (needs to be called when reading is over)                                                                 |
| `await SprenFlutter.cancelReading()`           |  | Cancels the ongoing reading                                                 |
| `await SprenFlutter.captureStart()`                |              | Starts camera capture |
| `await SprenFlutter.captureStop()`          |             | Stops camera capture                                                      |
| `await SprenFlutter.setAutoStart(bool)` *iOS only*           | `true`,`false`          | Set reading auto start. `autoStart` by default is false. Set `autoStart` to `true` if you want reading to start automatically.                                                             |
| `await SprenFlutter.dropComplexity()` *iOS only*  |   | Lower camera resolution and/or frame rate when phone load gets too high                                                              |
| `await SprenFlutter.setTorchMode(int)` *iOS only*        | `0`,`1`,`2`          | Configure flash light mode. torchMode possible values are: `0` - The capture device torch is always off. `1` - The capture device torch is always on. `2` - The capture device continuously monitors light levels and uses the torch when necessary.                                                                |
| `await SprenFlutter.captureLock()` *iOS only*     |          | Locks camera device configuration      |
| `await SprenFlutter.captureUnlock()` *iOS only*     |          | Unlocks camera device configuration      |
| `await SprenFlutter.turnFlashOn()` *Android only*     |          | Sets Flash On      |
| `await SprenFlutter.reset()` *Android only*     |          | Reset new reading to the beginning state      |

### Usage

For more elaborate usage example see [here](https://github.com/Elite-HRV/spren-vision-ios/tree/main/flutter/example).

For a quick entry point checkout this [file](https://github.com/Elite-HRV/spren-vision-ios/tree/main/flutter/example/lib/route/camera/camera.dart). 

