import 'package:flutter/material.dart';
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
      "width": width - 100,
      "height": height - 100
    };

    return FutureBuilder<AndroidDeviceInfo>(
        future: getDeviceInfo(),
        builder: (context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
          if (snapshot.hasData && snapshot.data!.isPhysicalDevice == true) {
            return SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.height - 100,
                child: AndroidView(
                  viewType: viewType,
                  layoutDirection: TextDirection.ltr,
                  creationParams: creationParams,
                  creationParamsCodec: const StandardMessageCodec(),
                )
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