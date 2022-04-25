import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spren_flutter_example/route/instructions/instruction3.dart';
import 'package:spren_flutter_example/route/instructions/instruction4.dart';
import 'package:spren_flutter_example/utils/adaptive_text_size.dart';

import '../../widgets/close_button.dart';

class RouteInstruction2 extends HookWidget {
  const RouteInstruction2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Image.asset('images/instruction2.png'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Place your fingertip over the rear-facing camera lens',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AdaptiveTextSize.instance
                          .getadaptiveTextSize(context, 21)),
                  textAlign: TextAlign.left),
              Text(
                'For the most accurate reading, leave the flash on or make sure you’re in a well lit area and can hold your hand steady',
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
              onPressed: () async {
                Map<Permission, PermissionStatus> statuses =
                    await [Permission.camera].request();
                if (statuses[Permission.camera] != PermissionStatus.granted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RouteInstruction3()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RouteInstruction4()),
                  );
                }
              },
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    ));
  }
}
