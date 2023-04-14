import 'package:beuty_app/res/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common_octo_image.dart';

Stack shopServiceStackProductBox(
    {String img, String serviceName, String price, String serviceCat}) {
  return Stack(
    // fit: StackFit.expand,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.grey.withOpacity(0.3),
          child: img == null || img == ''
              ? imageNotFound()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: commonOctoImage(
                      image: img, circleShape: false, fit: true),
                ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: Get.height * 0.06,
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        serviceName ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: Get.height * 0.017,
                            color: cWhite,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        serviceCat ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: Get.height * 0.014,
                            color: cWhite,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                      color: cWhite,
                      fontSize: Get.height * 0.015,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                )
              ],
            ),
          ),
        ),
      )
    ],
  );
}
