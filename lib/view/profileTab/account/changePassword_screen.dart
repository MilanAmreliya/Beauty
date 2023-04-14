import 'dart:developer';

import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/images.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/requestModel/change_password_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:beuty_app/viewModel/login_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangedPassword extends StatefulWidget {
  const ChangedPassword({Key key}) : super(key: key);

  @override
  _ChangedPasswordState createState() => _ChangedPasswordState();
}

class _ChangedPasswordState extends State<ChangedPassword> {
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
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    }),
              ),
            ),
            iLogoImage,
            // SizedBox(width: Get.width / 2),
            CommanWidget.sizedBox6_5(),

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
                          child: ChangePasswordForm(
                            formKey: formKey,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const ChangePasswordForm({Key key, this.formKey}) : super(key: key);

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  ValidationViewModel validationController = Get.find();
  TextEditingController newPasswordTextEditingController =
      TextEditingController();
  TextEditingController oldPasswordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height / 25,
              ),
              Center(
                child: Text(
                  "Change Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Manrope',
                      fontSize: 30),
                ),
              ),
              CommanWidget.sizedBox20(),

              ///Old Password ...
              CommanWidget.getTextFormField(
                labelText: "Password",
                textEditingController: oldPasswordTextEditingController,
                inputLength: 30,
                regularExpression: Utility.password,
                validationMessage: "Password is required",
                validationType: 'password',
                obscureOnTap: () {
                  validationController.passwordToggle();
                },
                obscureValue: validationController.passwordObscure.value,
                isIcon: 'isIcon',
                hintText: "Enter Old Password",
              ),

              ///new Password ...
              CommanWidget.getTextFormField(
                labelText: "Confirm password",
                textEditingController: newPasswordTextEditingController,
                inputLength: 30,
                regularExpression: Utility.password,
                validationMessage: "Password is required",
                obscureOnTap: () {
                  validationController.confirmPasswordToggle();
                },
                obscureValue: validationController.confirmPasswordObscure.value,
                validationType: 'password',
                isIcon: 'isIcon',
                hintText: "Enter new password",
              ),
              CommanWidget.sizedBox25(),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width / 8),
                  child: CommanWidget.activeButton(
                      onTap: () {
                        sendData(widget.formKey);
                      },
                      title: 'Update Password')),
            ],
          ),
        ),
        GetBuilder<LoginViewModel>(
          builder: (controller) {
            return controller.changePassApiResponse.status == Status.LOADING
                ? loadingIndicator()
                : SizedBox();
          },
        )
      ],
    );
  }

  Future<void> sendData(GlobalKey<FormState> formKey) async {
    if (formKey.currentState != null) {
      if (formKey.currentState.validate()) {
        validationController.progressVisible.value = true;
        FocusScope.of(context).unfocus();
        ChangePasswordReqModel model = ChangePasswordReqModel();
        LoginViewModel loginViewModel = Get.find();
        model.oldPassword = oldPasswordTextEditingController.text;
        model.newPassword = newPasswordTextEditingController.text;
        await loginViewModel.changePassword(model);

        if (loginViewModel.changePassApiResponse.status == Status.COMPLETE) {
          PostSuccessResponse response =
              loginViewModel.changePassApiResponse.data;
          if (response.message == "password is incorrect") {
            CommanWidget.snackBar(
              message: response.message,
            );
          } else {
            CommanWidget.snackBar(
              message: response.message,
            );
            Future.delayed(Duration(seconds: 1), () {
              Get.back();
              Get.back();
            });
          }
        } else {
          CommanWidget.snackBar(
            message: "Server Error",
          );
        }
        log(newPasswordTextEditingController.text);
        log(oldPasswordTextEditingController.text);
      }
    } else {
      CommanWidget.snackBar(
        message: Utility.somethingWentToWrong,
      );
    }
  }
}
