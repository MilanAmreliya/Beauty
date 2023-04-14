import 'dart:developer';

import 'package:beuty_app/model/apiModel/responseModel/login_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class LoginRepo extends BaseService {
  Future<LoginResponse> loginRepo(Map<String, dynamic> body) async {
    print('Login Req :$body');
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, url: loginURL, body: body);
    log("login res... :$response");
    LoginResponse registerResponse = LoginResponse.fromJson(response);
    return registerResponse;
  }
}
