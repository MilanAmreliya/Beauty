import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/color_picker.dart';

Widget showConnectionDialog({String desc,
    String title,}) {
  return Container(
    color: Colors.black54,
    child: Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        height: 160,
        width: Get.width - 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50,
              width: Get.width,
              decoration: BoxDecoration(
                  color: cRoyalBlue,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(20))),
              child: Center(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )),
            ),
            SizedBox(

              height: 30,
            ),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(

              height: 20,
            ),
          ],
        ),
      ),
    ),
  );
}