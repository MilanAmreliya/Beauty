import 'dart:developer';

import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/requestModel/login_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/login_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:beuty_app/services/app_notification.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/authScreen/forgotpassword/forgot_password_screen.dart';
import 'package:beuty_app/view/bottomBar/bottom_bar.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/login_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const SignInForm({Key key, this.formKey}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  ValidationViewModel validationController = Get.find();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  LoginViewModel loginViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height / 25,
                  ),

                  ///Email...
                  CommanWidget.getTextFormField(
                      labelText: "Email",
                      textEditingController: emailTextEditingController,
                      validationType: Utility.emailText,
                      hintText: "Enter Email Address",
                      inputLength: 50,
                      isIcon: 'isIcon',
                      regularExpression: Utility.emailAddressValidationPattern,
                      validationMessage: Utility.emailEmptyValidation,
                      sIcon: Icon(
                        Icons.email_outlined,
                        color: cLightGrey,
                      )),

                  ///Password ...
                  CommanWidget.getTextFormField(
                    labelText: "Password",
                    textEditingController: passwordTextEditingController,
                    inputLength: 30,
                    regularExpression: Utility.password,
                    validationMessage: "Password is required",
                    obscureOnTap: () {
                      validationController.loginPasswordToggle();
                    },
                    obscureValue:
                        validationController.loginPasswordObscure.value,
                    validationType: 'password',
                    hintText: "Enter Password",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.to(ForgotPassword());
                          // Get.to(MobileNumberVerification());
                        },
                        child: Text(
                          'Forgot password ?',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Container(
                      margin: EdgeInsets.symmetric(horizontal: Get.width / 8),
                      child: CommanWidget.activeButton(
                          onTap: () {
                            sendData(widget.formKey);
                          },
                          title: 'Login')),
                ],
              );
            })),
        GetBuilder<LoginViewModel>(
          builder: (controller) {
            if (controller.apiResponse.status == Status.LOADING) {
              return loadingIndicator();
            } else {
              return SizedBox();
            }
          },
        )
      ],
    );
  }

  void sendData(GlobalKey<FormState> formKey) async {
    ValidationViewModel controller = Get.find();
    String fmcToken = await AppNotificationHandler.getFcmToken();
log("DEVICE FCM TOKEN $fmcToken");
    if (formKey.currentState != null) {
      if (formKey.currentState.validate()) {
        validationController.progressVisible.value = true;
        FocusScope.of(context).unfocus();
        LoginRequestModel loginRequestModel = LoginRequestModel();
        loginRequestModel.email = emailTextEditingController.text;
        loginRequestModel.password = passwordTextEditingController.text;
        loginRequestModel.deviceToken = fmcToken;
        await loginViewModel.login(loginRequestModel);
        if (loginViewModel.apiResponse.status == Status.COMPLETE) {
          LoginResponse response = loginViewModel.apiResponse.data;

          if (response.success) {
            if (response.message == "loged in") {
              await PreferenceManager.setEmailId(response.user.email);
              var emailId = PreferenceManager.getEmailId();
              print("email id==>$emailId");
              await PreferenceManager.setUserName(response.user.username);
              var userName = PreferenceManager.getUserName();
              print("userName==>$userName");
              print("customerRole sigin ==>${response.user.customerRole}");

              await PreferenceManager.setCustomerRole(
                  response.user.customerRole);

              var customer_role = PreferenceManager.getCustomerRole();
              print("customer role signin form ==>$customer_role");

              await PreferenceManager.setArtistId(response.user.id);
              var artistId = PreferenceManager.getArtistId();
              print("ArtistId==>$artistId");

              await PreferenceManager.setToken(response.token);
              var token = PreferenceManager.getToken();
              print("Token==>$token");

              await PreferenceManager.setCustomerPImg(response.user.profilePic);
              var profileImage = PreferenceManager.getCustomerPImg();
              print("profileImage==>$profileImage");
              await PreferenceManager.setName(response.user.name);
              var name = PreferenceManager.getName();
              print("name==>$name");

              CommanWidget.snackBar(
                message: response.message,
              );
              controller.updateRole(customer_role);

              Future.delayed(Duration(seconds: 2), () async {
                BottomBarViewModel _barController = Get.find();
                _barController.setSelectedIndex(0);
                _barController.setSelectedRoute('HomeScreen');
                Get.offAll(BottomBar());
              });
            } else {
              CommanWidget.snackBar(
                message: response.message,
              );
            }
          } else {
            CommanWidget.snackBar(
              message: "unloged In",
            );
          }
        } else {
          CommanWidget.snackBar(
            message: "Server Error",
          );
        }
      }
    } else {
      CommanWidget.snackBar(
        message: Utility.somethingWentToWrong,
      );
    }
  }
}
