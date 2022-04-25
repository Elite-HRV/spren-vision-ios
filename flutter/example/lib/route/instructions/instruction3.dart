import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spren_flutter_example/utils/adaptive_text_size.dart';

import '../../widgets/close_button.dart';

class RouteInstruction3 extends HookWidget {
  const RouteInstruction3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useOnAppLifecycleStateChange(
        (AppLifecycleState? previous, AppLifecycleState current) {
      Navigator.pop(context);
    });
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(16, 25, 16, 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                CloseBtn(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ]),
              Image.asset('images/camera.png'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Camera access is needed to start an HRV measurement',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AdaptiveTextSize.instance
                          .getadaptiveTextSize(context, 21)),
                  textAlign: TextAlign.left),
              Text(
                'Allow access to camera in your iOS Settings in order to receive personalized insights and guidance.',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: AdaptiveTextSize.instance
                        .getadaptiveTextSize(context, 13)),
              ),
            ],
          ),
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
              child: const Text('Enable camera'),
            ),
          ),
        ],
      ),
    ));
  }
}
