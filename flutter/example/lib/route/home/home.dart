import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spren_flutter_example/route/instructions/instruction1.dart';
import 'package:spren_flutter_example/utils/adaptive_text_size.dart';

class RouteHome extends HookWidget {
  const RouteHome({Key? key}) : super(key: key);
  static int androidMinSdk = 28;

  @override
  Widget build(BuildContext context) {
    Future<AndroidDeviceInfo> getDeviceInfo() async {
      return await DeviceInfoPlugin().androidInfo;
    }

    return FutureBuilder<AndroidDeviceInfo>(
        future: getDeviceInfo(),
        builder: (context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.version.sdkInt != null &&
                snapshot.data!.version.sdkInt! < androidMinSdk) {
              return Scaffold(
                  body: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 50, 16, 18),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    'Unfortunately we do not support Android 8 or lower.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AdaptiveTextSize.instance
                                            .getadaptiveTextSize(context, 21)),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ],
                        ),
                      )));
            } else {
              return Scaffold(
                  body: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 50, 16, 18),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    'Unlock advanced HRV insights with your smartphone camera',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AdaptiveTextSize.instance
                                            .getadaptiveTextSize(context, 21)),
                                    textAlign: TextAlign.center),
                                Text(
                                  '\u2022 Integrate via SDK and API\n \u2022 Customizable look and feel\n \u2022 Validated algorithms',
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RouteInstruction1()),
                                  );
                                },
                                child: const Text('Try it now'),
                              ),
                            ),
                          ],
                        ),
                      )));
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
