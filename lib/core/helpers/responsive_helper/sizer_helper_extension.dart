import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/size_provider.dart';

extension SizerHelperExtension on BuildContext {
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  double get screenWidth =>
      isLandscape
          ? MediaQuery.of(this).size.height
          : MediaQuery.of(this).size.width;

  double get screenHeight =>
      isLandscape
          ? MediaQuery.of(this).size.width
          : MediaQuery.of(this).size.height;

  SizeProvider get sizeProvider => SizeProvider.of(this);

  double get scaleWidget => sizeProvider.width / sizeProvider.baseSize.width;
  double get scaleHight => sizeProvider.height / sizeProvider.baseSize.height;

  double setWidth(num w) {
    return w * scaleWidget;
  }

  double setHeight(num h) {
    return h * scaleHight;
  }

  double setSp(num sp) {
    return sp * scaleWidget;
  }

  double setMinSize(num size) {
    return size * min(scaleWidget, scaleHight);
  }
}
