import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'changePassword_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cThemColor,
      appBar: customAppBar('Account', leadingOnTap: () {
        Get.back();
      }),
      body: Container(
        height: Get.height / 1.3,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(ChangedPassword());
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                  size: Get.height * 0.035,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Change Password",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Get.height * 0.025,
                                        fontFamily: "Poppins"))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
