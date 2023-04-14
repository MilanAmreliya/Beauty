import 'package:beuty_app/model/apiModel/requestModel/likepost_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class IsLikedPostRepo extends BaseService {
  Future<PostSuccessResponse> isLikedPostRepo(IsLikedPostReq model) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: isLikedPostURL,
      body: model.toJson(),
    );
    PostSuccessResponse successResponse =
        PostSuccessResponse.fromJson(response);
    return successResponse;
  }
}
