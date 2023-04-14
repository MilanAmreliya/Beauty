import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget smallProfileHeader(
    {String name,
    String subName,
    String imageUrl,
    double offset,
    Color color = Colors.white,
    bool showPopup = true}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        SizedBox(
          width: 10,
        ),
        imageUrl == null || imageUrl == ''
            ? imageNotFound()
            : ClipOval(
                child: commonProfileOctoImage(
                  image: imageUrl,
                  height: Get.height * 0.07,
                  width: Get.height * 0.07,
                ),
              ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? '',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: color,
                  fontSize: Get.height / 40),
            ),
            Text(
              subName ?? '',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: color),
            ),
          ],
        ),
        Spacer(),
        showPopup
            ? popupBtnMenu(
                profileImg: imageUrl, offset: offset, color: Colors.black)
            : SizedBox(),
      ],
    ),
  );
}
