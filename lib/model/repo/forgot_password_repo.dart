import 'package:beuty_app/model/apiModel/requestModel/forgot_password_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/forgot_password_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class ForgotPasswordRepo extends BaseService {
  Future<ForgotPasswordResponse> forgotPasswordRepo(
      ForgotPasswordReqModel model) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: forgotPasswordURL,
      body: model.toJson(),
    );
    ForgotPasswordResponse result = ForgotPasswordResponse.fromJson(response);
    return result;
  }
}
