import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  final double progress;

  const ProgressBar({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 200,
        child: CircularPercentIndicator(
          radius: 100.0,
          lineWidth: 10.0,
          animation: true,
          animateFromLastPercent: true,
          percent: progress / 100,
          center: progress == 100 ? const Icon(
            Icons.done_rounded,
            color: Colors.black,
            size: 70,
          ) : null,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: const Color(0xFFE55775),
          backgroundColor: const Color(0xFFEFF2F5),
        ));
  }
}
