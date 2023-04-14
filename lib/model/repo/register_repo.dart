import 'package:beuty_app/model/apiModel/responseModel/register_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class RegisterRepo extends BaseService {
  Future<RegisterResponse> registerRepo(Map<String, dynamic> body) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, url: registerURL, body: body);
    print("res");
    RegisterResponse registerResponse = RegisterResponse.fromJson(response);
    print("end");
    return registerResponse;
  }
}
