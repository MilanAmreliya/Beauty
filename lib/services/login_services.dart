import 'package:beuty_app/comman/chat_initial.dart';
import 'package:beuty_app/comman/check_shop_exist.dart';
import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/dialogs/role_dialog.dart';
import 'package:beuty_app/model/apiModel/requestModel/check_user_exist_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/login_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/register_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/login_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/register_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/bottomBar/bottom_bar.dart';
import 'package:beuty_app/view/profileTab/shop_screen/create_shop_screen.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/login_viewmodel.dart';
import 'package:beuty_app/viewModel/register_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'app_notification.dart';

class LoginServices{

  static Future<void>  checkUserExist({String name,String email,String photoUrl,String loginStatus})async{

    LoginViewModel viewModel = Get.find();

    CheckUserExistRequestModel model = CheckUserExistRequestModel();
    model.email = email;
    await viewModel.checkUserExistLogin(model);
    if (viewModel.checkUserExistApiResponse.status == Status.COMPLETE) {
      PostSuccessResponse response = viewModel.checkUserExistApiResponse.data;
      if (response.message == "user not found") {
        await roleDialog(onTap: () {
          registerWithGoogle(email: email, name: name, photoUrl: photoUrl);
        });
      } else {
        await loginWithGoogle(email: email);
      }
    } else {
      if(loginStatus=='Google'){
        final GoogleSignIn googleSignIn = GoogleSignIn();

        await googleSignIn.signOut();

        CommanWidget.snackBar(
          message: 'Google Login failed',
        );
      }

    }
  }
 static  Future<void> registerWithGoogle(
      {String name, String email, String photoUrl}) async {
    RegisterRequestModel registerRequestModel = RegisterRequestModel();
    ValidationViewModel validationController = Get.find();
    String fmcToken = await AppNotificationHandler.getFcmToken();
    RegisterViewModel registerViewModel = Get.find();

    registerRequestModel.email = email;
    registerRequestModel.customerRole = validationController.selectRole.value;
    registerRequestModel.userName = name;
    registerRequestModel.name = name;
    registerRequestModel.password = "123456";
    registerRequestModel.type = "manually";
    registerRequestModel.deviceToken = fmcToken;
    print('req=>${registerRequestModel.toJson()}');
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
          print("customerRole ==>${response.customers.customerRole}");

          await PreferenceManager.setCustomerRole(
              response.customers.customerRole);

          var customer_role = PreferenceManager.getCustomerRole();
          print("customer role REG ==>$customer_role");

          await PreferenceManager.setArtistId(response.customers.id);
          var artistId = PreferenceManager.getArtistId();
          print("ArtistId==>$artistId");

          await PreferenceManager.setToken(response.accessToken);
          await PreferenceManager.setCustomerPImg(photoUrl);

          var token = PreferenceManager.getToken();
          print("Token==>$token");
          // FirebaseChatInitial();
          FirebaseChatInitial.userAddOneTimeInFirebase(
            artistId: response.customers.id.toString(),
            customerImage: photoUrl,
            toKen: response.customers.customerRole,
            username: name,
          );

          CommanWidget.snackBar(
            message: response.message,
          );
          Future.delayed(Duration(seconds: 1), () async {
            if (customer_role == 'Artist') {
              Get.offAll(CreateShopScreen(
                firstTimeCreate: true,
              ));
            } else {
              Get.offAll(BottomBar());
            }
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

 static Future<void> loginWithGoogle({String email}) async {
    LoginViewModel loginViewModel = Get.find();
    ValidationViewModel controller = Get.find();
    String fmcToken = await AppNotificationHandler.getFcmToken();

    LoginRequestModel loginRequestModel = LoginRequestModel();
    loginRequestModel.email = email;
    loginRequestModel.password = '123456';
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
          /// ShopPromotion
          var isPromotionShop = PreferenceManager.getShopPromotion();
          print("before promotion setShopPromotion==>$isPromotionShop");
          if (response.promotion.length > 0) {
            String dateTime=response.promotion[0].endDate.toString();

            await PreferenceManager.setShopPromotion(dateTime);
          }
          isPromotionShop = PreferenceManager.getShopPromotion();
          print("after promotion  setShopPromotion==>$isPromotionShop");
          print("customerRole ==>${response.user.customerRole}");

          await PreferenceManager.setCustomerRole(
              response.user.customerRole);


          var customer_role = PreferenceManager.getCustomerRole();
          print("customer role G ==>$customer_role");

          await PreferenceManager.setArtistId(response.user.id);
          var artistId = PreferenceManager.getArtistId();
          print("ArtistId==>$artistId");

          await PreferenceManager.setToken(response.token);
          var token = PreferenceManager.getToken();
          print("Token==>$token");
          CommanWidget.snackBar(
            message: response.message,
          );
          controller.updateRole(customer_role);

          Future.delayed(Duration(seconds: 1), () async {
            if (customer_role == 'Artist') {
              checkShopExist();
            } else {
              BottomBarViewModel _barController = Get.find();
              _barController.setSelectedIndex(0);
              _barController.setSelectedRoute('HomeScreen');
              Get.offAll(BottomBar());
            }
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
}