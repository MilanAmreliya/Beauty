import 'package:beuty_app/model/apiModel/requestModel/isfavorite_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class IsFavoritePostRepo extends BaseService {
  Future<PostSuccessResponse> isFavorite(IsFavoriteReq model) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: isFavoriteUrl,
      body: model.toJson(),
    );
    PostSuccessResponse successResponse =
        PostSuccessResponse.fromJson(response);
    return successResponse;
  }
}
