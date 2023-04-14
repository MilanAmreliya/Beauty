import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/share_method.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class FollowAndInviteFriendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cThemColor,
        appBar: customAppBar('Follow And Invite Friend', leadingOnTap: () {
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
                                customLaunch(
                                    'mailto:your@email.com?subject=test%20subject&body=test%20body');
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.mail_outline,
                                    color: Colors.black,
                                    size: Get.height * 0.035,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Invite Friends by Email",
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
                            GestureDetector(
                              onTap: () {
                                customLaunch('sms:5550101234');
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.sms_outlined,
                                    color: Colors.black,
                                    size: Get.height * 0.035,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Invite Friends by SMS",
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
                            GestureDetector(
                              onTap: () {
                                share(context, text: 'Invite Friends');
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: Colors.black,
                                    size: Get.height * 0.035,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Invite Friends by..",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Get.height * 0.025,
                                          fontFamily: "Poppins"))
                                ],
                              ),
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
      ),
    );
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }
}
