import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widget/mobile_number_form.dart';

class MobileNumberVerification extends StatefulWidget {
  const MobileNumberVerification({Key key}) : super(key: key);

  @override
  _MobileNumberVerificationState createState() =>
      _MobileNumberVerificationState();
}

class _MobileNumberVerificationState extends State<MobileNumberVerification> {
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
                  padding: EdgeInsets.only(bottom: 50),
                  physics: BouncingScrollPhysics(),
                  children: [
                    Form(
                        key: formKey,
                        child: MobileNumberForm(
                          formKey: formKey,
                        )),
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
