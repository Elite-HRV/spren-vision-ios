import 'package:flutter/material.dart';

class FlashDisableButton extends StatelessWidget {
  final Function(int mode) notifyParent;

  const FlashDisableButton({Key? key, required this.notifyParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset('images/flash_disable.png'),
      onPressed: () {
        notifyParent(0);
      },
    );
  }
}
