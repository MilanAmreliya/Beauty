import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum KeyPointer { img }

CommentAndLikePostViewModel likePostViewModel = Get.find();

Future<void> shopItemDialog({
  bool isOnTap = false,
  String userName,
  String userRole,
  String userImg,
  String description,
  double rating,
  String shopImg,
}) {
  return Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),

    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: StatefulBuilder(builder: (context, dialogSetState) {
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.01, horizontal: Get.width * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            topProfileView(
                title: userName, subTitle: userRole, profileImg: userImg),
            SizedBox(
              height: Get.height * 0.005,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: Get.height * 0.35,
                    width: Get.width,
                    color: Colors.grey.withOpacity(0.3),
                    child: shopImg == null || shopImg == ''
                        ? imageNotLoadRectangle()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: commonOctoImage(
                              image: shopImg,
                              circleShape: false,
                            ))),
                SizedBox(
                  height: Get.height * 0.02,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            specificationView(description),
          ],
        ),
      );
    }),
  ));
}

Padding topProfileView({String title, String subTitle, String profileImg}) {
  print('image:$profileImg');
  return Padding(
    padding:
        EdgeInsets.only(right: Get.width * 0.03, bottom: 10, top: 10, left: 10),
    child: Row(
      children: [
        profileImg == null || profileImg == ''
            ? imageNotFound()
            : ClipOval(
                child: commonProfileOctoImage(
                  image: profileImg,
                  height: Get.height * 0.06,
                  width: Get.height * 0.06,
                ),
              ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Get.height * 0.02,
                  fontFamily: "Poppins"),
            ),
            Text(
              subTitle ?? '',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: Get.height * 0.016,
                  fontFamily: "Poppins"),
            ),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: () async {
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff424BE1), width: 1)),
            child: Icon(
              Icons.clear,
              color: Color(0xff424BE1),
            ),
          ),
        ),
      ],
    ),
  );
}

Padding specificationView(
  String description,
) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specification',
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: Get.height * 0.02,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Text(
          description ?? '',
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.grey,
              fontSize: Get.height * 0.014,
              fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}
