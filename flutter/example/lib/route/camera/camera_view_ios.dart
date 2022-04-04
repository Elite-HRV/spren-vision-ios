import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';

class CameraView extends StatelessWidget {
  final double width;
  final double height;

  const CameraView({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String viewType = 'cameraView';

    Future<IosDeviceInfo> getDeviceInfo() async {
      return await DeviceInfoPlugin().iosInfo;
    }

    final Map<String, dynamic> creationParams = <String, dynamic>{
      "width": width,
      "height": height
    };

    return FutureBuilder<IosDeviceInfo>(
        future: getDeviceInfo(),
        builder: (context, AsyncSnapshot<IosDeviceInfo> snapshot) {
          if (snapshot.hasData && snapshot.data!.isPhysicalDevice) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: UiKitView(
                  viewType: viewType,
                  layoutDirection: TextDirection.ltr,
                  creationParams: creationParams,
                  creationParamsCodec: const StandardMessageCodec(),
                )
            );
          } else if (snapshot.hasData && !snapshot.data!.isPhysicalDevice) {
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