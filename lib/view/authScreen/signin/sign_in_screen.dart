import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/dialog.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/services/google_login.dart';
import 'package:beuty_app/view/authScreen/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'widget/signin_form.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    formKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cDarkBlue,
      child: Column(
        children: [
          CommanWidget.appLogo(),
          Expanded(
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
                child: ListView(
                  // shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 50),
                  physics: BouncingScrollPhysics(),
                  children: [
                    Form(
                        key: formKey,
                        child: SignInForm(
                          formKey: formKey,
                        )),
                    CommanWidget.sizedBox10(),
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
                    CommanWidget.sizedBox10(),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              signInWithGoogle();
                              // googleLoginDialog();
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
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
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
                    CommanWidget.sizedBox15(),
                    InkWell(
                      onTap: () {
                        Get.to(SignUpScreen());
                      },
                      child: Center(
                        child: Text("Don't have an account? Register",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Manrope',
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
