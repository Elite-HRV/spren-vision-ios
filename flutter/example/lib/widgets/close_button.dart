import 'package:flutter/material.dart';

class CloseBtn extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;
  const CloseBtn({Key? key, required this.color, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.close,
        color: color,
        size: 35,
      ),
      onPressed: onPressed,
    );
  }
}
