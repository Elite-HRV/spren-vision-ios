import 'package:flutter/services.dart';

typedef Listener = void Function(dynamic msg);
typedef CancelListening = void Function();

int nextListenerId = 1;

CancelListening startListeningStateChange(Listener listener) {
  const _channel = EventChannel('com.spren/spren_flutter_event_state_change');
  var subscription = _channel
      .receiveBroadcastStream(nextListenerId++)
      .listen(listener, cancelOnError: true);
  return () {
    subscription.cancel();
  };
}

CancelListening startListeningPreReadingComplianceCheckChange(
    Listener listener) {
  const _channel = EventChannel(
      'com.spren/spren_flutter_event_pre_reading_compliance_check');
  var subscription = _channel
      .receiveBroadcastStream(nextListenerId++)
      .listen(listener, cancelOnError: true);
  return () {
    subscription.cancel();
  };
}

CancelListening startListeningProgressChange(
    Listener listener) {
  const _channel = EventChannel(
      'com.spren/spren_flutter_event_progress_update');
  var subscription = _channel
      .receiveBroadcastStream(nextListenerId++)
      .listen(listener, cancelOnError: true);
  return () {
    subscription.cancel();
  };
}
