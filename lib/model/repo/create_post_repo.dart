import 'package:beuty_app/model/apiModel/requestModel/create_post_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class CreatePostRepo extends BaseService {
  Future<PostSuccessResponse> createPostRepo(CreatePostReqModel model) async {
    Map<String, dynamic> body = await model.toJson();
    print('reqq=>$body');
    var response = await ApiService().getResponse(
        apiType: APIType.aPost,
        url: createPostURL,
        body: body,
        fileUpload: true);
    PostSuccessResponse result = PostSuccessResponse.fromJson(response);
    return result;
  }
}
