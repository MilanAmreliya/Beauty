import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'images.dart';

class CommanWidget {
  static ValidationViewModel validationController =
      Get.put(ValidationViewModel());
  static InputBorder outLineGrey = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: cLightGrey, width: 1.0),
  );
  static InputBorder outLineRed = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: Colors.red, width: 1.0),
  );

  static sizedBox25() {
    return SizedBox(
      height: 25,
    );
  }

  static sizedBox50() {
    return SizedBox(
      height: 50,
    );
  }

  static sizedBox20() {
    return SizedBox(
      height: 20,
    );
  }

  static sizedBox6_5() {
    return SizedBox(height: Get.width / 6.5);
  }

  static sizedBoxD3() {
    return SizedBox(
      height: Get.width / 3,
    );
  }

  static sizedBox15() {
    return SizedBox(
      height: 15,
    );
  }

  static sizedBox10() {
    return SizedBox(
      height: 10,
    );
  }

  static sizedBox5() {
    return SizedBox(
      height: 5,
    );
  }

  static getTextFormField(
      {String labelText,
      TextEditingController textEditingController,
      bool isValidate,
      bool isReadOnly = false,
      bool isEnable,
      TextInputType textInputType,
      String validationType,
      String regularExpression,
      int inputLength,
      String hintText,
      String isIcon,
      String validationMessage,
      String iconPath,
      int maxLine,
      IconData icon,
      Widget sIcon,
      Function obscureOnTap,
      bool obscureValue,
      Function onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(color: cTextLabel),
        ),
        labelText != ""
            ? SizedBox(
                height: 10,
              )
            : SizedBox(),
        Container(
          // height: 40,
          // color: Colors.lightGreen,
          child: Stack(
            children: [
              TextFormField(
                readOnly: isReadOnly,
                showCursor: !isReadOnly,
                keyboardType: textInputType,
                onTap: onTap,
                maxLines: maxLine == null ? 1 : maxLine,
                controller: textEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(inputLength),
                  FilteringTextInputFormatter.allow(RegExp(regularExpression)),
                ],
                enabled: isEnable != null ? isEnable : true,
                validator: (value) {
                  print("isValidate  $isValidate}");
                  return isValidate == false
                      ? null
                      : value.isEmpty
                          ? validationMessage
                          : validationType == "email"
                              ? Utility.validateUserName(value)
                              : validationType == "password"
                                  ? Utility.validatePassword(value)
                                  : validationType == "mobileno"
                                      ? value.length != 10
                                          ? Utility
                                              .mobileNumberInValidValidation
                                          : null
                                      : null;
                },
                style: TextStyle(
                    color: isEnable != null ? Colors.black : Colors.black,
                    fontSize: 14),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    focusedBorder: outLineGrey,
                    enabledBorder: outLineGrey,
                    isDense: true,
                    isCollapsed: true,
                    contentPadding:
                        EdgeInsets.only(top: 15, bottom: 15, left: 10),
                    errorBorder: outLineRed,
                    focusedErrorBorder: outLineRed,
                    hintText: hintText,
                    suffixIcon: sIcon),
                obscureText:
                    validationType == 'password' ? obscureValue : false,
              ),
              validationType == 'password'
                  ? Positioned(
                      right: Get.height * 0.02,
                      top: Get.height * 0.018,
                      child: InkWell(
                        onTap: obscureOnTap,
                        child: Icon(
                          !obscureValue
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: cLightGrey,
                          size: Get.height * 0.025,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        labelText != ""
            ? SizedBox(
                height: 10,
              )
            : SizedBox(),
      ],
    );
  }

  static void snackBar({
    String message,
  }) {
    Get.showSnackbar(GetBar(
      padding: EdgeInsets.only(bottom: 10, left: 20),
      messageText: Text(
        "$message",
        style: TextStyle(color: Colors.white),
      ),
      title: '',
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: cRoyalBlue1,
    ));
  }

  static Widget activeButton({title, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          width: Get.width,
          height: 50,
          decoration: BoxDecoration(
              color: cRoyalBlue,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                cRoyalBlue1,
                cPurple,
              ])),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          )),
    );
  }

  static Widget profileMenus({width, title, iconName, onClick}) {
    return InkWell(
      // onTap: onClick,
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 50,
              child: SvgPicture.asset(
                "assets/svg/$iconName.svg",
                height: 50,
                width: 50,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  color: cTextLabel,
                  // color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  static Widget addPhotoWidget() {
    return Container(
      height: Get.width / 4.5,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          svgAddPhoto,
          Text(
            " Add photo",
            style: TextStyle(color: cLightGrey),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cLightGrey)),
    );
  }

  static Widget transparentButton(
      {String title, Function onTap, Color borderColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: borderColor == null ? 50 : 20),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? Colors.black,
            ),
            borderRadius: BorderRadius.circular(35.0),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(35.0),
            onTap: onTap,
            child: Container(
              height: Get.height * 0.045,
              width: Get.width,
              child: Center(
                  child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Manrope',
                    fontSize: 16,
                    color: borderColor ?? Colors.black),
              )),
            ),
          ),
        ),
      ),
    );
  }

  static Widget appLogo() {
    return Column(
      children: [
        SizedBox(
          height: Get.width / 10,
        ),
        iLogoImage,
        SizedBox(
          height: Get.width / 6.5,
        ),
      ],
    );
  }
}


