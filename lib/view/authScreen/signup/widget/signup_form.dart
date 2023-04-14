import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/requestModel/register_request_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:beuty_app/view/authScreen/mobileverification/verify_mobileno_screen.dart';
import 'package:beuty_app/viewModel/register_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const SignUpForm({Key key, this.formKey}) : super(key: key);

  // const SignUpForm(GlobalKey<FormState> formKey, {Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  ValidationViewModel validationController = Get.find();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  RegisterViewModel registerViewModel = Get.find();
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
/*
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

                  GetBuilder<ValidationViewModel>(
                    builder: (controller) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Artist/Model",
                            style: TextStyle(color: cTextLabel),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.focusScope.unfocus();
                              roleDialog();
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: cLightGrey, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.0)),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text(
                                    '${controller.selectRole.value == '' ? 'choose your role' : controller.selectRole.value}',
                                    style: TextStyle(
                                        color: controller.selectRole.value == ''
                                            ? Colors.black54
                                            : Colors.black,
                                        fontSize: 14),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.person_outline_outlined,
                                    color: cLightGrey,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  ),

                  ///Username...
                  CommanWidget.getTextFormField(
                      labelText: "Username",
                      textEditingController: userNameTextEditingController,
                      hintText: "Enter user name",
                      inputLength: 30,
                      isIcon: 'isIcon',
                      regularExpression: Utility.alphabetSpaceValidationPattern,
                      validationMessage: Utility.nameEmptyValidation,
                      sIcon: Icon(
                        Icons.person_outline_outlined,
                        color: cLightGrey,
                      )),

                  ///Name...
                  CommanWidget.getTextFormField(
                      labelText: "Name",
                      textEditingController: nameTextEditingController,
                      hintText: "Enter your name",
                      inputLength: 30,
                      isIcon: 'isIcon',
                      regularExpression: Utility.alphabetSpaceValidationPattern,
                      validationMessage: Utility.nameEmptyValidation,
                      sIcon: Icon(
                        Icons.person_outline_outlined,
                        color: cLightGrey,
                      )),

                  ///Password ...
                  CommanWidget.getTextFormField(
                    labelText: "Password",
                    textEditingController: passwordTextEditingController,
                    inputLength: 30,
                    regularExpression: Utility.password,
                    validationMessage: "Password is required",
                    validationType: 'password',
                    obscureOnTap: () {
                      validationController.passwordToggle();
                    },
                    obscureValue: validationController.passwordObscure.value,
                    isIcon: 'isIcon',
                    hintText: "Enter Password",
                  ),
                  CommanWidget.getTextFormField(
                    labelText: "Confirm password",
                    textEditingController: confirmPasswordTextEditingController,
                    inputLength: 30,
                    regularExpression: Utility.password,
                    validationMessage: "Password is required",
                    obscureOnTap: () {
                      validationController.confirmPasswordToggle();
                    },
                    obscureValue:
                        validationController.confirmPasswordObscure.value,
                    validationType: 'password',
                    isIcon: 'isIcon',
                    hintText: "Enter Confirm Password",
                  ),
                  SizedBox(
                    height: 15,
                  ),*/

                  ///Terms & Condition
                  _termsNCondition(),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: Get.width / 8),
                      child: CommanWidget.activeButton(
                          onTap: () {
                            sendData(widget.formKey);
                          },
                          title: 'Register')),
                ],
              );
            })),
        GetBuilder<RegisterViewModel>(
          init: registerViewModel,
          builder: (controller) {
            if (registerViewModel.apiResponse.status == Status.LOADING) {
              return loadingIndicator();
            } else {
              return SizedBox();
            }
          },
        )
      ],
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

  Future<void> sendData(formKey) async {
    if (formKey.currentState != null) {
      if (formKey.currentState.validate()) {
        if (validationController.selectRole.value == '') {
          CommanWidget.snackBar(
            message: Utility.artistModelRoleMessage,
          );
          return;
        }
        if (passwordTextEditingController.text !=
            confirmPasswordTextEditingController.text) {
          CommanWidget.snackBar(
            message: "Password and Confirm Password does not match!",
          );
          return;
        }
        if (validationController.termCondition.value) {
          validationController.progressVisible.value = true;
          FocusScope.of(context).unfocus();
          RegisterRequestModel registerRequestModel = RegisterRequestModel();
          registerRequestModel.email = emailTextEditingController.text;
          registerRequestModel.customerRole =
              validationController.selectRole.value;
          registerRequestModel.name = nameTextEditingController.text;
          registerRequestModel.userName = userNameTextEditingController.text;
          registerRequestModel.password = passwordTextEditingController.text;
          registerRequestModel.confirmPassword =
              confirmPasswordTextEditingController.text;
          registerRequestModel.type = "manually";
          Get.to(MobileNumberVerification());
        } else {
          CommanWidget.snackBar(
            message: Utility.termsConditionsMessage,
          );
        }
      }
    } else {
      CommanWidget.snackBar(
        message: Utility.emailEmptyValidation,
      );
    }
  }
}

