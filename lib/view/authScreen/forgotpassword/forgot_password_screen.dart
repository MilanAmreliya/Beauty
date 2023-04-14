import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widget/forgotpassword_form.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                        child: ForgotPasswordForm(
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
