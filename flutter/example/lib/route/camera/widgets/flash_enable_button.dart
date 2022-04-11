import 'package:flutter/material.dart';

class FlashEnableButton extends StatelessWidget {
  final Function(int mode) notifyParent;

  const FlashEnableButton({Key? key, required this.notifyParent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset('images/flash_enable.png'),
      onPressed: () {
        notifyParent(0);
      },
    );
  }
}
