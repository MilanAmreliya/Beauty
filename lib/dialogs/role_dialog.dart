import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/view/genralScreen/help_screen.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> roleDialog({Function onTap}) {
  String selectedRole = 'Artist';
  return Get.dialog(
      WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRole = 'Artist';
                            });
                          },
                          child: Container(
                            decoration: selectedRole == 'Artist'
                                ? BoxDecoration(
                                    border:
                                        Border.all(color: cRoyalBlue, width: 3))
                                : BoxDecoration(),
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: Get.height * 0.05,
                                  backgroundImage:
                                      AssetImage('assets/image/artist.png'),
                                ),
                                Text(
                                  'Artist',
                                  style: TextStyle(
                                      fontSize: Get.height * 0.02,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRole = 'Model';
                            });
                          },
                          child: Container(
                            decoration: selectedRole == 'Model'
                                ? BoxDecoration(
                                    border:
                                        Border.all(color: cRoyalBlue, width: 3))
                                : BoxDecoration(),
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: Get.height * 0.05,
                                  backgroundImage:
                                      AssetImage('assets/image/model.png'),
                                ),
                                Text(
                                  'Model',
                                  style: TextStyle(
                                      fontSize: Get.height * 0.02,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(HelpScreen());
                      },
                      child: Text(
                        'Help ?',
                        style: TextStyle(
                            fontSize: Get.height * 0.015,
                            fontFamily: "poppins",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                        onPressed: () {
                          ValidationViewModel validationController = Get.find();
                          validationController.updateRole(selectedRole);
                          if (onTap != null) {
                            onTap();
                          }
                          Get.back();
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ))
                  ],
                );
              },
            ),
          ),
        ),
      ),
      barrierDismissible: onTap == null ? true : false);
}
