import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spren_flutter_example/route/camera/camera_view_ios.dart';
import 'package:spren_flutter_example/route/camera/camera_view_overlay/camera_view_overlay.dart';
import 'package:wakelock/wakelock.dart';

class RouteCamera extends StatefulWidget {
  const RouteCamera({Key? key}) : super(key: key);

  @override
  State<RouteCamera> createState() => CameraState();
}

class CameraState extends State<RouteCamera> {
  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Wakelock.enable();

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError('Unsupported platform view');
      case TargetPlatform.iOS:
        return Scaffold(
          body: Stack(children: <Widget>[
            CameraView(width: width, height: height),
            CameraViewOverlay(width, height),
          ]),
        );
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }
}
