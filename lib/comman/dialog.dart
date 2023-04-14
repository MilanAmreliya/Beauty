import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget facebookLoginDialog() {
  Get.dialog(Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: Get.height * 0.03,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: Get.height * 0.1,
            width: Get.width * 0.225,
            child: Stack(
              children: [
                // CircleAvatar(
                //   radius: Get.height * 0.5,
                //   backgroundImage: AssetImage('assets/image/userprofile.png'),
                // ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: Get.width * 0.05,
                    height: Get.height * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle,
                      color: Color(0xff2DB80A),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Text(
            'Robert phan',
            style: TextStyle(
                fontSize: Get.height * 0.025,
                fontFamily: "Manrope",
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: Text(
              'QQQ will have access to name, email address and other public info.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Get.height * 0.018,
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Container(
            width: Get.width,
            height: Get.height * 0.08,
            decoration: BoxDecoration(color: Color(0xff1574F4)),
            child: Center(
              child: Text(
                'Continue as Robort',
                style: TextStyle(
                    fontFamily: "Manrope",
                    fontSize: Get.height * 0.02,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    ),
  ));
}

Widget googleLoginDialog() {
  Get.dialog(Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.03, horizontal: Get.width * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: Get.height * 0.05,
            backgroundImage: AssetImage('assets/image/loginwithgoogleimg.png'),
          ),
          Text(
            'Choose an account',
            style: TextStyle(
                fontSize: Get.height * 0.025,
                fontFamily: "Manrope",
                fontWeight: FontWeight.w600),
          ),
          Text(
            'to continue QQQ',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: Get.height * 0.020,
                fontFamily: "Manrope",
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          centerUserDetail(),
          SizedBox(
            height: Get.height * 0.02,
          ),
          addUser()
        ],
      ),
    ),
  ));
}

Row addUser() {
  return Row(
    children: [
      CircleAvatar(
        radius: Get.height * 0.025,
        backgroundColor: Colors.transparent,
        child: Image.asset(
          'assets/image/adduser.png',
        ),
      ),
      SizedBox(
        width: Get.width * 0.03,
      ),
      Text(
        'Add another account',
        style: TextStyle(
            fontFamily: "Manrope",
            fontWeight: FontWeight.w600,
            fontSize: Get.height * 0.02),
      )
    ],
  );
}

Row centerUserDetail() {
  return Row(
    children: [
      CircleAvatar(
        radius: Get.height * 0.025,
        backgroundColor: Color(0xff03589B),
        child: Center(
          child: Text(
            'R',
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Manrope",
                fontWeight: FontWeight.w500,
                fontSize: Get.height * 0.025),
          ),
        ),
      ),
      SizedBox(
        width: Get.width * 0.03,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Robert phan',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Manrope",
              fontSize: Get.height * 0.02,
            ),
          ),
          Text(
            'demo@gmail.com',
            style: TextStyle(
                fontFamily: "Manrope",
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w400,
                color: Colors.grey),
          )
        ],
      ),
    ],
  );
}
