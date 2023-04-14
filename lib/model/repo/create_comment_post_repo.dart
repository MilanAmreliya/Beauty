import 'package:beuty_app/model/apiModel/requestModel/create_comment_post_request.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class CreateCommentPostRepo extends BaseService {
  Future<PostSuccessResponse> createCommentPost(
      CreateCommentPostReq model) async {
    Map<String, dynamic> body = await model.toJson();
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: createCommentPostURL,
      body: body,
    );
    PostSuccessResponse postSuccessResponse =
        PostSuccessResponse.fromJson(response);
    return postSuccessResponse;
  }
}
