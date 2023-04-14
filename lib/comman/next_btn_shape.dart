import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/text_style.dart';
import 'package:flutter/cupertino.dart';

Widget nextBtnShape({Function functionOnTap}){
  return GestureDetector(
    onTap: functionOnTap,
    child: Container(
      width: 60,
      margin: EdgeInsets.fromLTRB(0, 17, 10, 17),
      decoration: BoxDecoration(
          border: Border.all(color: cRoyalBlue),
          borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Text(
          'Next',
          style: nextBtnStyle(),
        ),
      ),
    ),
  );
}