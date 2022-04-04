import 'package:flutter/cupertino.dart';

class AdaptiveTextSize {
  const AdaptiveTextSize();

  AdaptiveTextSize._privateConstructor();

  static final AdaptiveTextSize instance = AdaptiveTextSize._privateConstructor();

  getadaptiveTextSize(BuildContext context, dynamic value) {
    // 720 is medium screen height
    return (value / 720) * MediaQuery.of(context).size.height;
  }
}