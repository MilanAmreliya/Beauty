//
// import 'dart:convert';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:http/http.dart' as http;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// Future facebookLogin(BuildContext context) async {
//   final facebookLogin = FacebookLogin();
//   final result = await facebookLogin.logIn(['email']);
//   facebookLogin.loginBehavior = FacebookLoginBehavior.nativeOnly;
//   switch (result.status) {
//     case FacebookLoginStatus.loggedIn:
//       FbgetInformation(
//           result.accessToken.token, context, result.accessToken.userId);
//       print('succ');
//       break;
//     case FacebookLoginStatus.cancelledByUser:
//       print('cancleby user');
//       break;
//     case FacebookLoginStatus.error:
//       print('internet Error');
//       break;
//   }
// }
//
// void FbgetInformation(String fbToken, context, String userid) async {
//   var graphResponse = await http.get(Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${fbToken}')
//       );
//
//   var profile = jsonDecode(graphResponse.body);
//   cusSetGoogleOrFbLogin(key: 'googleLogin', value: false);
//   cusSetLoginUserData(key: 'UserId', value: userid);
//   cusSetLoginUserData(key: 'Username', value: profile['first_name']);
//   cusSetLoginUserData(
//       key: 'UserPhotoUrl', value: profile['picture']['data']['url']);
//   Navigator.pushAndRemoveUntil(context,
//       MaterialPageRoute(builder: (context) => Home()), (route) => false);
// }
//
//
//
//
//
//
// Future signInWithGoogle(BuildContext context) async {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   try {
//     final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//     final GoogleSignInAuthentication googleSignInAuthentication =
//     await googleSignInAccount.authentication;
//
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleSignInAuthentication.accessToken,
//       idToken: googleSignInAuthentication.idToken,
//     );
//     cusSetGoogleOrFbLogin(key: 'googleLogin', value: true);
//     cusSetLoginUserData(key: 'UserId', value: googleSignInAccount.id);
//     cusSetLoginUserData(
//         key: 'Username',
//         value: googleSignInAccount.displayName
//             .substring(0, googleSignInAccount.displayName.lastIndexOf(' ')));
//     cusSetLoginUserData(
//         key: 'UserPhotoUrl', value: googleSignInAccount.photoUrl);
//     Navigator.pushAndRemoveUntil(context,
//         MaterialPageRoute(builder: (context) => Home()), (route) => false);
//   } catch (e) {
//     print(e);
//   }
// }
