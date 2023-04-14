import 'package:beuty_app/model/apiModel/requestModel/create_service_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class CreateServiceRepo extends BaseService {
  Future<PostSuccessResponse> createServiceRepo(
      CreateServiceReqModel model) async {
    Map<String, dynamic> body = await model.toJson();

    var response = await ApiService().getResponse(
        apiType: APIType.aPost,
        url: createServiceURL,
        body: body,
        fileUpload: true);
    print("responcce==>$response");
    print("Body request Add services.  ==> $body");
    PostSuccessResponse result = PostSuccessResponse.fromJson(response);
    return result;
  }
}
