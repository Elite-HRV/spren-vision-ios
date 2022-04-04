import 'package:flutter/material.dart';
import 'package:spren_flutter_example/route/camera/camera.dart';
import 'package:spren_flutter_example/utils/adaptive_text_size.dart';

class RouteHome extends StatelessWidget {
  const RouteHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'Welcome to the Flutter Spren demo app',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AdaptiveTextSize.instance.getadaptiveTextSize(context, 21)
                    ),
                    textAlign: TextAlign.center
                  ),
                  Text(
                    'This is a demo app to test out the fastest way to incorporate biomarker science into your offering.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: AdaptiveTextSize.instance.getadaptiveTextSize(context, 13)
                    ),
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
                        fontSize: AdaptiveTextSize.instance.getadaptiveTextSize(context, 13)
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RouteCamera()),
                    );
                  },
                  child: const Text('Do an HRV reading'),
                ),
              )
            ],
          ),
        )
      )
    );
  }
}