
import 'package:beuty_app/model/apiModel/requestModel/register_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/register_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/model/repo/register_repo.dart';
import 'package:get/get.dart';

class RegisterViewModel extends GetxController {
  ApiResponse apiResponse = ApiResponse.initial('Initial');

  Future<void> register(RegisterRequestModel model) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      RegisterResponse response =
          await RegisterRepo().registerRepo(model.toJson());
      apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('error.....$e');
      apiResponse = ApiResponse.error('error');
    }
    update();
  }
}
