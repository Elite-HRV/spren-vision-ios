import 'package:flutter/material.dart';
import 'package:spren_flutter_example/route/home/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const SprenDemoApp());
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
