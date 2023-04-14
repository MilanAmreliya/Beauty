import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/model/apiModel/responseModel/check_shop_available_response_model.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/dialogs/role_dialog.dart';
import 'package:beuty_app/model/apiModel/requestModel/check_user_exist_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/login_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/register_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/login_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/register_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/view/bottomBar/bottom_bar.dart';
import 'package:beuty_app/view/profileTab/shop_screen/create_shop_screen.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/login_viewmodel.dart';
import 'package:beuty_app/viewModel/register_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:beuty_app/comman/chat_initial.dart';
import 'package:beuty_app/comman/check_shop_exist.dart';

import 'app_notification.dart';
import 'login_services.dart';

ValidationViewModel validationController = Get.find();

Future signInWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  try {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    String name = googleSignInAccount.displayName
        .substring(0, googleSignInAccount.displayName.lastIndexOf(' '));
    String email = googleSignInAccount.email;
    String photoUrl = googleSignInAccount.photoUrl;
    print('name : $name');
    print('p Url : ${googleSignInAccount.photoUrl}');
    print('email : ${googleSignInAccount.email}');
    await LoginServices.checkUserExist(
      email: email,
      name:name,
      photoUrl: photoUrl
    );
    validationController.termCondition.value = false;
  } catch (e) {
    CommanWidget.snackBar(
      message: 'Google Login failed',
    );

    print(e);
  }
}


