import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spren_flutter_example/route/camera/camera.dart';
import 'package:spren_flutter_example/utils/adaptive_text_size.dart';
import 'package:permission_handler/permission_handler.dart';

class RouteHome extends HookWidget {
  const RouteHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cameraPermission = useState(-1);

    Future<void> onInit() async {
      var status = await Permission.camera.status;
      cameraPermission.value = status.isGranted ? 1 : 0;
    }

    useEffect(() {
      onInit();
    }, []);

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 18),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: Image.asset('images/logo.png'),
                      ),
                      Image.asset('images/home.png'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Welcome to the Flutter Spren demo app',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AdaptiveTextSize.instance
                                  .getadaptiveTextSize(context, 21)),
                          textAlign: TextAlign.center),
                      Text(
                        'This is a demo app to test out the fastest way to incorporate biomarker science into your offering.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: AdaptiveTextSize.instance
                                .getadaptiveTextSize(context, 13)),
                      ),
                    ],
                  ),
                  if (cameraPermission.value == 0)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          padding: const EdgeInsets.all(15),
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AdaptiveTextSize.instance
                                  .getadaptiveTextSize(context, 13)),
                        ),
                        onPressed: () {
                          openAppSettings();
                        },
                        child: const Text('Open App Settings'),
                      ),
                    ),
                  if (cameraPermission.value == 1)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          padding: const EdgeInsets.all(15),
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AdaptiveTextSize.instance
                                  .getadaptiveTextSize(context, 13)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RouteCamera()),
                          );
                        },
                        child: const Text('Do an HRV reading'),
                      ),
                    ),
                ],
              ),
            )));
  }
}
