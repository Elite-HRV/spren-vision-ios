import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog getLightInsufficientModal(BuildContext context, Function() btnOkOnPress, Function() btnCancelOnPress) {
  AwesomeDialog lightInsufficientModal = AwesomeDialog(
    context: context,
    dialogType: DialogType.WARNING,
    animType: AnimType.BOTTOMSLIDE,
    title: 'There is not enough light for the measurement',
    desc: 'Please move to a well lit area or turn your flashlight on.',
    btnOkOnPress: btnOkOnPress,
    dismissOnBackKeyPress: false,
    dismissOnTouchOutside: false,
    btnCancelOnPress: btnCancelOnPress,
    btnOkColor: const Color(0xff5246A8),
    btnOkText: 'Turn on flash',
    btnCancelText: 'Cancel',
  );

  return lightInsufficientModal;
}

AwesomeDialog getReadingStoppedModal(BuildContext context, Function() btnOkOnPress) {
  AwesomeDialog readingStoppedModal = AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Reading stopped, please try again',
    desc: 'Make sure you are in a well lit area.',
    dismissOnBackKeyPress: false,
    dismissOnTouchOutside: false,
    btnOkOnPress: btnOkOnPress,
    btnOkColor: const Color(0xff5246A8),
    btnOkText: 'Try again',
  );

  return readingStoppedModal;
}