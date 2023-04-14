import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/story_comment_request_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class StoryCommentRepo extends BaseService {
  Future<PostSuccessResponse> storyComment(
      StoryCommentRequestModel model) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: storyCommentURL,
      body: model.toJson(),
    );
    PostSuccessResponse result = PostSuccessResponse.fromJson(response);
    return result;
  }
}
