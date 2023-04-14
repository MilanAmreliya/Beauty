import 'package:beuty_app/res/color_picker.dart';
import 'package:flutter/material.dart';

BoxDecoration bottomRadiusDecoration() {
  return BoxDecoration(
      color: cWhite,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)));
}

BoxDecoration gradientDecoration({double radius}) {
  return BoxDecoration(
      color: cRoyalBlue1,
      borderRadius: BorderRadius.circular(radius ?? 35),
      gradient: LinearGradient(colors: [
        cRoyalBlue1,
        cPurple,
      ]));
}
