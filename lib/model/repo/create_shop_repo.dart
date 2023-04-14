import 'package:beuty_app/model/apiModel/requestModel/add_shop_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class CreateShopRepo extends BaseService {
  Future<PostSuccessResponse> createShopRepo(CreateShopReqModel model) async {
    Map<String, dynamic> body = await model.toJson();

    var response = await ApiService().getResponse(
        apiType: APIType.aPost,
        url: createShopURL,
        body: body,
        fileUpload: true);
    PostSuccessResponse result = PostSuccessResponse.fromJson(response);
    return result;
  }
}
