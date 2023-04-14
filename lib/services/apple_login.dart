import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/res/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_services.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLogin {
  static Future<void> appleLogIn() async {
    if (await AppleSignIn.isAvailable()) {
      final AuthorizationResult result = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [
          Scope.email,
          Scope.fullName,
        ])
      ]);

      switch (result.status) {
        case AuthorizationStatus.authorized:
          getInfo(result.credential);
          print(
              'success :${result.credential.user}'); //All the required credentials'break;
          break;
        case AuthorizationStatus.error:
          CommanWidget.snackBar(
            message: 'Sign in failed: ${result.error.localizedDescription}',
          );
          break;
        case AuthorizationStatus.cancelled:
          print('User cancelled');
          break;
      }
    } else {
      CommanWidget.snackBar(
        message: 'Apple SignIn is not available for your device',
      );
      print('Apple SignIn is not available for your device');
    }
  }

  static Future<void> getInfo(AppleIdCredential credential) async {
    String email = credential.email;
    String name =
        credential.fullName.givenName ?? credential.fullName.familyName;
    if (credential.email == null) {
      email = await getEmailFromFirebase(credential.user);
    } else {
      await addEmailFromFirebase(email, credential.user);
    }

    await LoginServices.checkUserExist(
      email: email,
      name: name,
    );
  }

  static Future<String> getEmailFromFirebase(String userId) async {
    DocumentSnapshot doc = await appleIdsCollection.doc(userId).get();
    if (doc.exists) {
      return doc.get('email');
    }
    return 'demo@gmail.com';
  }

  static Future<void> addEmailFromFirebase(String email, String userId) async {
    await appleIdsCollection
        .doc(userId)
        .set({'email': email}).catchError((e) => print('add email error :$e'));
  }
}
