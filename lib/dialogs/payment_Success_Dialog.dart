import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> paymentSuccessDialog() async {
  return Get.dialog(Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/image/check.png'),
          Text(
            'Successful',
            style: TextStyle(
                fontSize: Get.height * 0.025,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins"),
          ),
          Text(
            'Appiontment booked',
            style: TextStyle(
                color: Colors.grey,
                fontSize: Get.height * 0.016,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins"),
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.02),
            child: customBtn(
                title: 'Next',
                height: Get.height * 0.042,
                width: Get.width * 0.23,
                radius: Get.width * 0.09,
                onTap: () {
                  Get.back();
                  Get.back();
                  BottomBarViewModel _barController = Get.find();
                  _barController.setSelectedRoute('HomeScreen');
                }),
          ),
        ],
      ),
    ),
  ));
}
