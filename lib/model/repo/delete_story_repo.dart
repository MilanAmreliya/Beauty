import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class DeleteStoryRepo extends BaseService {
  Future<PostSuccessResponse> deleteStoryRepo(
      String storyId, String userId) async {
    String url = deleteStoryURL + userId + "/" + storyId;
    var response =
        await ApiService().getResponse(apiType: APIType.aGet, url: url);
    PostSuccessResponse result = PostSuccessResponse.fromJson(response);
    return result;
  }
}
