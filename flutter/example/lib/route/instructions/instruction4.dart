import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spren_flutter_example/route/camera/camera.dart';
import 'package:spren_flutter_example/utils/adaptive_text_size.dart';

import '../../widgets/close_button.dart';

class RouteInstruction4 extends HookWidget {
  const RouteInstruction4({Key? key}) : super(key: key);

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
              Image.asset('images/instruction3.png'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Place your fingertip fully over the camera lens',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AdaptiveTextSize.instance
                          .getadaptiveTextSize(context, 21)),
                  textAlign: TextAlign.left),
              Text(
                'Hold your hand steady and apply light pressure with your finger.',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RouteCamera()),
                );
              },
              child: const Text('Start measurement'),
            ),
          ),
        ],
      ),
    ));
  }
}
