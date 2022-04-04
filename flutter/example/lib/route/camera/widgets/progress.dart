import 'package:flutter/material.dart';
import 'package:spren_flutter_example/route/camera/widgets/progress_bar.dart';
import 'package:spren_flutter_example/route/camera/widgets/progress_text_helper.dart';
import 'package:spren_flutter_example/utils/adaptive_text_size.dart';

class CameraProgress extends StatelessWidget {
  final int progress;

  const CameraProgress({Key? key, required this.progress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CameraProgressBar(progress: progress.toDouble()),
          const SizedBox(width: 15),
          Expanded(
              child: Text(
            getProgressText(progress),
            style: TextStyle(
                fontSize:
                    AdaptiveTextSize.instance.getadaptiveTextSize(context, 13)),
          ))
        ],
      ),
    );
  }
}
