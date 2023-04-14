
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class DeletePostRepo extends BaseService {
  Future<PostSuccessResponse> deletePost(String postId) async {
    String artistId = PreferenceManager.getArtistId().toString();
    String url = "$deletePostURL$artistId/$postId";
    var response =
        await ApiService().getResponse(apiType: APIType.aGet, url: url);
    PostSuccessResponse result = PostSuccessResponse.fromJson(response);
    return result;
  }
}
