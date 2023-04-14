import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/dialog.dart';
import 'package:beuty_app/comman/images.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:beuty_app/services/apple_login.dart';
import 'package:beuty_app/services/google_login.dart';
import 'package:beuty_app/view/authScreen/signin/sign_in_screen.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'widget/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // GlobalKey<FormState> formKey;
  ValidationViewModel validationController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    // formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cDarkBlue,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 2, child: CommanWidget.appLogo()),
            Expanded(
              flex: 3,
              child: Container(
                // height: Get.height,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40))),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 50),
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        // Form(
                        //     key: formKey,
                        //     child: SignUpForm(
                        //       formKey: formKey,
                        //     )),

                        Center(
                          child: Text(
                            "Login With",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Manrope',
                                fontSize: 20),
                          ),
                        ),
                        CommanWidget.sizedBox15(),

                        ///Terms & Condition
                        _termsNCondition(),
                        CommanWidget.sizedBox10(),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Platform.isIOS?InkWell(
                                  onTap: () {
                                    if (!validationController
                                        .termCondition.value) {
                                      CommanWidget.snackBar(
                                        message: Utility.termsConditionsMessage,
                                      );
                                      return;
                                    }

                                      ///apple login
                                      AppleLogin.appleLogIn();

                                  },
                                  child: Container(
                                    height: Get.width * 0.15,
                                    width: Get.width * 0.15,
                                    decoration: BoxDecoration(
                                        color: cRoyalBlue1,
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              cRoyalBlue1,
                                              cPurple,
                                            ])),
                                    child: Center(
                                        child: SvgPicture.asset(
                                            "assets/svg/appleLogo.svg")),
                                  )):SizedBox(),
                              SizedBox(
                                width: Platform.isIOS?10:0,
                              ),InkWell(
                                  onTap: () {
                                    if (!validationController
                                        .termCondition.value) {
                                      CommanWidget.snackBar(
                                        message: Utility.termsConditionsMessage,
                                      );
                                      return;
                                    }

                                      ///google login
                                      signInWithGoogle();


                                  },
                                  child: Container(
                                    height: Get.width * 0.15,
                                    width: Get.width * 0.15,
                                    decoration: BoxDecoration(
                                        color: cRoyalBlue1,
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              cRoyalBlue1,
                                              cPurple,
                                            ])),
                                    child: Center(
                                        child: SvgPicture.asset(
                                            "assets/svg/Glogog.svg")),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    if (!validationController
                                        .termCondition.value) {
                                      CommanWidget.snackBar(
                                        message: Utility.termsConditionsMessage,
                                      );
                                      return;
                                    }
                                    // signInWithGoogle();
                                    facebookLoginDialog();
                                  },
                                  child: Container(
                                    height: Get.width * 0.15,
                                    width: Get.width * 0.15,
                                    decoration: BoxDecoration(
                                        color: cRoyalBlue1,
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              cRoyalBlue1,
                                              cPurple,
                                            ])),
                                    child: Center(
                                        child: SvgPicture.asset(
                                            "assets/svg/flogo.svg")),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _termsNCondition() {
    return Obx(() {
      return Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 22,
              width: 22,
              child: Checkbox(
                value: validationController.termCondition.value,
                onChanged: (value) {
                  validationController.termCondition.value =
                      !validationController.termCondition.value;
                  print("T&C Chnage --> " +
                      validationController.termCondition.value.toString());

                  // validationController.chnageTC();
                },
                checkColor: Colors.white,
                activeColor: cThemColor,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'I agree to Tearm & Privacy Policy',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    });
  }
}
