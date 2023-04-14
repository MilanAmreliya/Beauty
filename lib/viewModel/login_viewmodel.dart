
import 'package:beuty_app/model/apiModel/requestModel/change_password_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/check_user_exist_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/forgot_password_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/login_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/forgot_password_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/login_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/model/repo/change_password_repo.dart';
import 'package:beuty_app/model/repo/check_user_exist_repo.dart';
import 'package:beuty_app/model/repo/forgot_password_repo.dart';
import 'package:beuty_app/model/repo/login_repo.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  ApiResponse apiResponse = ApiResponse.initial('Initial');
  ApiResponse checkUserExistApiResponse = ApiResponse.initial('Initial');
  ApiResponse changePassApiResponse = ApiResponse.initial('Initial');
  ApiResponse forgotPassApiResponse = ApiResponse.initial('Initial');

  ///login...
  Future<void> login(LoginRequestModel model) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      LoginResponse response = await LoginRepo().loginRepo(model.toJson());
      apiResponse = ApiResponse.complete(response);
      print("LOGIN RES:$response");
    } catch (e) {
      print('error.....$e');
      apiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// check user exist..
  Future<void> checkUserExistLogin(CheckUserExistRequestModel model) async {
    checkUserExistApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response =
          await CheckUserExistRepo().checkUserExist(model);
      checkUserExistApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('error.....$e');
      checkUserExistApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Change Password...
  Future<void> changePassword(ChangePasswordReqModel model) async {
    changePassApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response =
          await ChangePasswordRepo().changePassword(model);
      changePassApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('error.....$e');
      changePassApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///forgot password....
  Future<void> forgotPassword(ForgotPasswordReqModel model) async {
    forgotPassApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ForgotPasswordResponse response =
          await ForgotPasswordRepo().forgotPasswordRepo(model);
      forgotPassApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('error.....$e');
      forgotPassApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
