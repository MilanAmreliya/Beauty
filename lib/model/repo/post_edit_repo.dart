import 'package:beuty_app/model/apiModel/responseModel/post_edit_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class PostEditRepo extends BaseService {
  Future<PostEditResponse> postEditRepo(
      Map<String, dynamic> body, String feedId) async {
    String userId = PreferenceManager.getArtistId().toString();
    String url = postEditURL + feedId + '/' + userId;
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, url: url, body: body);
    print("res");
    PostEditResponse postEditResponse = PostEditResponse.fromJson(response);
    print("end");
    return postEditResponse;
  }
}
