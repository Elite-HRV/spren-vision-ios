import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';

class CameraViewAndroid extends StatelessWidget {
  final double width;
  final double height;

  const CameraViewAndroid({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String viewType = 'cameraView';

    Future<AndroidDeviceInfo> getDeviceInfo() async {
      return await DeviceInfoPlugin().androidInfo;
    }

    final Map<String, dynamic> creationParams = <String, dynamic>{
      "width": width,
      "height": height
    };

    return FutureBuilder<AndroidDeviceInfo>(
        future: getDeviceInfo(),
        builder: (context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
          if (snapshot.hasData && snapshot.data!.isPhysicalDevice == true) {
            return SizedBox(
                width: width,
                height: height,
                child: PlatformViewLink(
                  viewType: viewType,
                  surfaceFactory:
                      (context, controller) {
                    return AndroidViewSurface(
                      controller: controller as AndroidViewController,
                      gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                      hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                    );
                  },
                  onCreatePlatformView: (params) {
                    return PlatformViewsService.initExpensiveAndroidView(
                      id: params.id,
                      viewType: viewType,
                      layoutDirection: TextDirection.ltr,
                      creationParams: creationParams,
                      creationParamsCodec: const StandardMessageCodec(),
                      onFocus: () {
                        params.onFocusChanged(true);
                      },
                    )
                      ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
                      ..create();
                  },
                ),
            );
          } else if (snapshot.hasData && snapshot.data!.isPhysicalDevice == false) {
            return Container(
              width: width,
              height: height,
              color: Colors.teal,
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
    );
  }
}