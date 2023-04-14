
import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/package/custom_text_field.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:beuty_app/view/authScreen/otp/otp_screen.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MobileNumberForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const MobileNumberForm({Key key, this.formKey}) : super(key: key);

  @override
  _MobileNumberFormState createState() => _MobileNumberFormState();
}

class _MobileNumberFormState extends State<MobileNumberForm> {
  TextEditingController mobileNoTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  bool number = false;
  ValidationViewModel validationController = Get.find();
  int root = 1;
  String pCode;

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
              Text(
                "Verify",
                style: TextStyle(
                    color: cTextLabel,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Manrope',
                    fontSize: 18),
              ),
              SizedBox(
                height: Get.height / 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /* Text(
                    "Email",
                    style: TextStyle(
                        color: cTextLabel,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Manrope',
                        fontSize: 18),
                  ),
                  Radio(
                    value: 0,
                    focusNode: FocusNode(),
                    groupValue: root,
                    activeColor: cRoyalBlue,
                    onChanged: (value) {
                      */ /*setState(() {
                        root = value;
                        emailTextEditingController.clear();
                      });*/ /*
                    },
                  ),*/
                  Text(
                    "Mobile",
                    style: TextStyle(
                        color: cTextLabel,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Manrope',
                        fontSize: 18),
                  ),
                  Radio(
                    value: 1,
                    groupValue: root,
                    activeColor: cRoyalBlue,
                    focusNode: FocusNode(),
                    onChanged: (value) {
                      setState(() {
                        root = value;
                        mobileNoTextEditingController.clear();
                      });
                    },
                  ),
                ],
              ),
              Center(
                child: root == 0
                    ? Text(
                        "Continue  Using your Email",
                        style: TextStyle(
                            color: cTextLabel,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Manrope',
                            fontSize: 18),
                      )
                    : Text(
                        "Continue Using your phone number",
                        style: TextStyle(
                            color: cTextLabel,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Manrope',
                            fontSize: 18),
                      ),
              ),
              CommanWidget.sizedBox20(),

              ///Mobile Number...
              root == 0
                  ? CommanWidget.getTextFormField(
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
                      ))
                  : CustomTextField(
                      controller: mobileNoTextEditingController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onCh: (phone, String code) {
                        if (phone.length == 10) {
                          setState(() {
                            number = true;
                          });
                        } else if (phone.length < 10 && number) {
                          setState(() {
                            number = false;
                          });
                        }
                        print("Mobilenumber ==> $phone $code}");
                        pCode = code;
                      },
                    ),

              CommanWidget.sizedBox50(),

              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width / 8),
                  child: CommanWidget.activeButton(
                      onTap: () {
                        sendData(widget.formKey, pCode);
                        //log(mobileNoTextEditingController.text);
                        /*  if (root == 0) {
                          sendData(widget.formKey);

                          log(emailTextEditingController.text);
                        } else {
                          sendData(widget.formKey);

                          log(mobileNoTextEditingController.text);
                        }*/
                      },
                      title: 'Continue')),
            ],
          ),
        ),
        GetBuilder<ValidationViewModel>(
          builder: (controller) {
            return controller.isLoading.value ? loadingIndicator() : SizedBox();
          },
        )
      ],
    );
  }

  void sendData(GlobalKey<FormState> formKey, String pCode) {
    if (formKey.currentState != null) {
      if (root == 0) {
        if (emailTextEditingController.text != null &&
            emailTextEditingController.text != "") {
          if (formKey.currentState.validate()) {
            // otpSend(pCode);
          }
        } else {
          CommanWidget.snackBar(
            message: Utility.emailEmptyValidation,
          );
        }
      } else {
        if (mobileNoTextEditingController.text != null &&
            mobileNoTextEditingController.text != "") {
          if (mobileNoTextEditingController.text.length == 10) {
            validationController.progressVisible.value = true;
            FocusScope.of(context).unfocus();
            otpSend(
              pNumber: mobileNoTextEditingController.text,
              countryCode: pCode,
            );

            /*    await SignUpService().signUp(
                          email: emailTextEditingController.text,
                          password: passwordTextEditingController.text,
                          fullName: nameTextEditingController.text,
                          mobileNo: mobileNoTextEditingController.text,
                          buildContext: context); */
          } else {
            CommanWidget.snackBar(
              message: Utility.kMobileNoLengthValidation,
            );
          }
        } else {
          CommanWidget.snackBar(
            message: Utility.mobileNumberInValidValidation,
          );
        }
      }
    } else {
      CommanWidget.snackBar(
        message: Utility.mobileNumberInValidValidation,
      );
    }
  }
}

Future<void> otpSend({String pNumber, String countryCode}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  ValidationViewModel validationController = Get.find();
  validationController.updateIsLoading(true);
  print('num+>$pNumber}');
  await auth.verifyPhoneNumber(
    phoneNumber: '$countryCode$pNumber',
    verificationCompleted: (phoneAuthCredential) async {
      print('Verification Complete..');
      validationController.updateIsLoading(false);
    },
    verificationFailed: (verificationFailed) async {
      CommanWidget.snackBar(
        message: verificationFailed.message,
      );
      validationController.updateIsLoading(false);
    },
    codeSent: (verificationId, resendingToken) async {
      verificationId = verificationId;
      Get.to(OTPScreen(
        verificationId: verificationId,
      ));
      validationController.updateIsLoading(false);
    },
    codeAutoRetrievalTimeout: (verificationId) async {
      validationController.updateIsLoading(false);
    },
  );
}
