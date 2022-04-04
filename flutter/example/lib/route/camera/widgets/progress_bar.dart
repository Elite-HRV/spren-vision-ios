import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:spren_flutter_example/utils/adaptive_text_size.dart';
import 'package:sprintf/sprintf.dart';

class CameraProgressBar extends StatelessWidget {
  final double progress;

  const CameraProgressBar({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 78,
        height: 78,
        child: CircularPercentIndicator(
          radius: 38.0,
          lineWidth: 8.0,
          animation: true,
          animateFromLastPercent: true,
          percent: progress / 100,
          center: Text(
            sprintf('%2.0f%s', [progress, '%']),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                    AdaptiveTextSize.instance.getadaptiveTextSize(context, 13),
                color: Colors.black),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: const Color(0xFF27CF71),
          backgroundColor: const Color(0xFFEFF2F5),
        ));
  }
}
