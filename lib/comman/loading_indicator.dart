import 'package:beuty_app/res/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Container loadingIndicator() {
  return Container(
      height: Get.height,
      width: Get.width,
      color: Colors.black26,
      child: Center(
        child: circularIndicator(),
      ));
}

Widget circularIndicator(){
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(cRoyalBlue),
  );
}
