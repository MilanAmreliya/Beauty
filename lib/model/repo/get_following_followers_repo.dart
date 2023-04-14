
import 'package:beuty_app/model/apiModel/responseModel/following_followers_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class GetFollowingFollowersRepo extends BaseService {
  Future<FollowingFollowersResponse> getAllFollowingFollowers(
      String artistId) async {
    // String artistId = PreferenceManager.getArtistId().toString();
    print('id....=>$artistId}');
    var response = await ApiService().getResponse(
        apiType: APIType.aGet, url: followingFollowersURL + artistId);
    FollowingFollowersResponse result =
        FollowingFollowersResponse.fromJson(response);

    return result;
  }
}
