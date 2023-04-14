import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/requestModel/forgot_password_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/forgot_password_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:beuty_app/viewModel/login_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const ForgotPasswordForm({Key key, this.formKey}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  TextEditingController emailTextEditingController = TextEditingController();
  ValidationViewModel validationController = Get.find();
  LoginViewModel loginViewModel = Get.find();

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
                  "Reissue Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Manrope',
                      fontSize: 30),
                ),
              ),
              CommanWidget.sizedBox20(),

              ///Email...
              CommanWidget.getTextFormField(
                  labelText: "Enter email",
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
              CommanWidget.sizedBox50(),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width / 8),
                  child: CommanWidget.activeButton(
                      onTap: () {
                        sendData(widget.formKey);
                      },
                      title: 'Next')),
            ],
          ),
        ),
        GetBuilder<LoginViewModel>(
          builder: (controller) {
            if (controller.forgotPassApiResponse.status == Status.LOADING) {
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
    if (formKey.currentState != null) {
      if (formKey.currentState.validate()) {
        validationController.progressVisible.value = true;
        FocusScope.of(context).unfocus();
        ForgotPasswordReqModel forgotPasswordReqModel =
            ForgotPasswordReqModel();
        forgotPasswordReqModel.email = emailTextEditingController.text;
        await loginViewModel.forgotPassword(forgotPasswordReqModel);
        if (loginViewModel.forgotPassApiResponse.status == Status.COMPLETE) {
          ForgotPasswordResponse response =
              loginViewModel.forgotPassApiResponse.data;

          if (response.success) {
            CommanWidget.snackBar(
              message: response.message,
            );
            return;
          }
        } else {
          ForgotPasswordResponse response =
              loginViewModel.forgotPassApiResponse.data;

          CommanWidget.snackBar(
            message: "The given data was invalid.",
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
