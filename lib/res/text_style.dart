import 'package:beuty_app/res/color_picker.dart';
import 'package:flutter/material.dart';

TextStyle appBarTitleStyle() {
  return TextStyle(
      color: cRoyalBlue, fontFamily: 'Poppins', fontWeight: FontWeight.w600);
}

TextStyle postTitleStyle({Color color}) {
  return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: color ?? Colors.black);
}

TextStyle postSubtitleStyle() {
  return TextStyle(color: cLightGrey, fontSize: 12);
}

TextStyle nextBtnStyle() {
  return TextStyle(
      fontFamily: 'Poppins',
      color: cRoyalBlue,
      fontSize: 12,
      fontWeight: FontWeight.w600);
}
