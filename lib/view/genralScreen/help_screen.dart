import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cThemColor,
        appBar: customAppBar('Help', leadingOnTap: () {
          Get.back();
        }),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text(
                Utility.privacyPolicyText,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    fontFamily: 'Poppins'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
