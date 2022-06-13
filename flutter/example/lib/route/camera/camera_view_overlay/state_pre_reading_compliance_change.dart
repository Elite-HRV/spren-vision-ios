import 'package:tuple/tuple.dart';
import 'package:spren_flutter/spren_model.dart';

Tuple4<int, int, int, int> onStatePreReadingComplianceCheckChange(dynamic message) {
  int droppedFrames =
      message['name'] == SprenComplicanceChecks.frameDrop.toShortString() &&
              message['compliant'] == false
          ? 1
          : 0;
  int brightness =
      message['name'] == SprenComplicanceChecks.brightness.toShortString() &&
              message['compliant'] == false
          ? 1
          : 0;
  int lensCoverage =
      message['name'] == SprenComplicanceChecks.lensCoverage.toShortString() &&
              message['compliant'] == false
          ? 1
          : 0;

  int exposure =
      message['name'] == SprenComplicanceChecks.exposure.toShortString() &&
              message['compliant'] == false
          ? 1
          : 0;

  return Tuple4<int, int, int, int>(droppedFrames, brightness, lensCoverage, exposure);
}
