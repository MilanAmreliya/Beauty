import 'package:beuty_app/comman/chat_initial.dart';
import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/requestModel/register_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/register_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/bottomBar/bottom_bar.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/register_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String verificationId;

  const OTPForm({Key key, this.formKey, this.verificationId}) : super(key: key);

  @override
  _OTPFormState createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  TextEditingController otpTextEditingController = TextEditingController();
  ValidationViewModel validationController = Get.find();

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
                  "Enter Verification Code",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Manrope',
                      fontSize: 28),
                ),
              ),
              CommanWidget.sizedBox5(),
              Container(
                width: Get.width / 1.5,
                child: Center(
                  child: Text(
                    "An OTP has been sent to your number.If you don’t get OTP within 1 minutesplease try again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: cLightGrey,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Manrope',
                        fontSize: 12),
                  ),
                ),
              ),
              CommanWidget.sizedBox20(),

              ///OTP...
              CommanWidget.getTextFormField(
                labelText: "OTP",
                textEditingController: otpTextEditingController,
                inputLength: 6,
                regularExpression: Utility.digitsValidationPattern,
                validationMessage: Utility.otpInValidValidation,
                hintText: "OTP",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Respond OTP',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '54s',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              CommanWidget.sizedBox50(),

              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width / 8),
                  child: CommanWidget.activeButton(
                      onTap: () {
                        sendData(widget.formKey);
                      },
                      title: 'Verify')),
            ],
          ),
        ),
        GetBuilder<ValidationViewModel>(
          builder: (controller) {
            return controller.isLoading.value ? loadingIndicator() : SizedBox();
          },
        ),
        GetBuilder<RegisterViewModel>(
          builder: (controller) {
            return controller.apiResponse.status == Status.LOADING
                ? loadingIndicator()
                : SizedBox();
          },
        ),
      ],
    );
  }

  void sendData(GlobalKey<FormState> formKey) {
    if (formKey.currentState != null) {
      if (formKey.currentState.validate()) {
        validationController.progressVisible.value = true;
        FocusScope.of(context).unfocus();
        // Get.offAll(BottomBar());
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: widget.verificationId,
            smsCode: otpTextEditingController.text);

        signInWithPhoneAuthCredential(phoneAuthCredential);
      }
    } else {
      CommanWidget.snackBar(
        message: Utility.somethingWentToWrong,
      );
    }
  }
}

Future<void> signInWithPhoneAuthCredential(
    PhoneAuthCredential phoneAuthCredential) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  ValidationViewModel validationController = Get.find();
  validationController.updateIsLoading(true);
  try {
    final authCredential = await auth.signInWithCredential(phoneAuthCredential);
    validationController.updateIsLoading(false);

    if (authCredential?.user != null) {
      register();
    }
  } on FirebaseAuthException catch (e) {
    validationController.updateIsLoading(false);
  }
}

Future<void> register() async {
  RegisterRequestModel registerRequestModel = RegisterRequestModel();
  RegisterViewModel registerViewModel = Get.find();

  await registerViewModel.register(registerRequestModel);
  if (registerViewModel.apiResponse.status == Status.COMPLETE) {
    RegisterResponse response = registerViewModel.apiResponse.data;
    if (response.success) {
      if (response.message == "register successfully") {
        await PreferenceManager.setEmailId(response.customers.email);
        var emailId = PreferenceManager.getEmailId();
        print("email id==>$emailId");
        await PreferenceManager.setUserName(response.customers.username);
        var userName = PreferenceManager.getUserName();
        print("userName==>$userName");

        await PreferenceManager.setCustomerRole(
            response.customers.customerRole);

        var customer_role = PreferenceManager.getCustomerRole();
        print("customer role==>$customer_role");

        await PreferenceManager.setArtistId(response.customers.id);
        var artistId = PreferenceManager.getArtistId();
        print("ArtistId==>$artistId");

        await PreferenceManager.setToken(response.accessToken);
        var token = PreferenceManager.getToken();
        print("Token==>$token");
        FirebaseChatInitial.userAddOneTimeInFirebase(
          artistId: response.customers.id.toString(),
          customerImage: '',
          toKen: response.customers.customerRole,
          username: response.customers.username,
        );

        CommanWidget.snackBar(
          message: response.message,
        );
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
        message: "Register unsuccessfully",
      );
    }
  } else {
    CommanWidget.snackBar(
      message: "Server Error",
    );
  }
}
