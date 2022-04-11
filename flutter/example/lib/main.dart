import 'package:flutter/material.dart';
import 'package:spren_flutter_example/route/home/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await SentryFlutter.init(
        (options) {
      options.dsn = dotenv.env['SENTRY_DNS'];
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const SprenDemoApp()),
  );
}

class SprenDemoApp extends StatelessWidget {
  const SprenDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spren Demo',
      theme: ThemeData(fontFamily: 'Sofia Pro'),
      home: const RouteHome(),
    );
  }
}
