import 'package:flutter/material.dart';
import 'package:spren_flutter_example/utils/adaptive_text_size.dart';

class PoweredBy extends StatelessWidget {
  const PoweredBy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              'Powered by',
              style: TextStyle(
                color: const Color(0xffB5B5B5),
                  fontSize: AdaptiveTextSize.instance.getadaptiveTextSize(context, 10)
              ),
          ),
          const SizedBox(width: 10),
          Image.asset('images/logo.png', width: 50),
        ]
    );
  }
}
