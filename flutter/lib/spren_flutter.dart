import 'dart:async';

import 'package:flutter/services.dart';

class SprenFlutter {
  static const MethodChannel _channel =
      MethodChannel('com.spren/spren_flutter_method');

  /// Set reading auto start. autoStart by default is false
  /// Set autoStart to true if you want reading to start automatically.
  static Future<void> setAutoStart(bool autoStart) async {
    try {
      return await _channel.invokeMethod(
          'setAutoStart', <String, dynamic>{'autoStart': autoStart});
    } on PlatformException catch (e) {
      throw 'Unable to run setAutoStart: ${e.message}';
    }
  }

  /// Configure flash light mode. torchMode possible values are:
  /// 0 - The capture device torch is always off.
  /// 1 - The capture device torch is always on.
  /// 2 - The capture device continuously monitors light levels and uses the torch when necessary.
  static Future<void> setTorchMode(int torchMode) async {
    try {
      return await _channel.invokeMethod(
          'setTorchMode', <String, dynamic>{'torchMode': torchMode});
    } on PlatformException catch (e) {
      throw 'Unable to run setTorchMode: ${e.message}';
    }
  }

  /// Returns reading data information (needs to be called when reading is over)
  static Future<String> getReadingData() async {
    try {
      return await _channel.invokeMethod('getReadingData');
    } on PlatformException catch (e) {
      throw 'Unable to run getReadingData: ${e.message}';
    }
  }

  /// Cancels the ongoing reading
  static Future<void> cancelReading() async {
    try {
      return await _channel.invokeMethod('cancelReading');
    } on PlatformException catch (e) {
      throw 'Unable to run cancelReading: ${e.message}';
    }
  }

  /// Starts camera capture
  static Future<void> captureStart() async {
    try {
      return await _channel.invokeMethod('captureStart');
    } on PlatformException catch (e) {
      throw 'Unable to run captureStart: ${e.message}';
    }
  }

  /// Stops camera capture
  static Future<void> captureStop() async {
    try {
      return await _channel.invokeMethod('captureStop');
    } on PlatformException catch (e) {
      throw 'Unable to run captureStop: ${e.message}';
    }
  }

  /// Lower camera resolution and/or frame rate when phone load gets too high
  static Future<void> dropComplexity() async {
    try {
      return await _channel.invokeMethod('dropComplexity');
    } on PlatformException catch (e) {
      throw 'Unable to run dropComplexity: ${e.message}';
    }
  }

  /// Locks camera device configuration
  static Future<void> captureLock() async {
    try {
      return await _channel.invokeMethod('captureLock');
    } on PlatformException catch (e) {
      throw 'Unable to run captureLock: ${e.message}';
    }
  }

  /// Unlocks camera device configuration
  static Future<void> captureUnlock() async {
    try {
      return await _channel.invokeMethod('captureUnlock');
    } on PlatformException catch (e) {
      throw 'Unable to run captureUnlock: ${e.message}';
    }
  }
}
