import 'package:beuty_app/model/apiModel/requestModel/create_story_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class CreateStoryRepo extends BaseService {
  Future<PostSuccessResponse> createStoryRepo(CreateStoryReqModel model) async {
    Map<String, dynamic> body = await model.toJson();

    var response = await ApiService().getResponse(
        apiType: APIType.aPost,
        url: createStoryURL,
        body: body,
        fileUpload: true);
    PostSuccessResponse result = PostSuccessResponse.fromJson(response);
    return result;
  }
}
