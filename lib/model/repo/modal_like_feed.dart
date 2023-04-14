import 'package:beuty_app/model/apiModel/responseModel/modal_like_feed.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class ModelLikedFeedRepo extends BaseService {
  Future<ModelLikedFeedResponse> modelLikedFeedRepo() async {
    String artistId = PreferenceManager.getArtistId().toString();
    print('model ID :$artistId');
    var response = await ApiService()
        .getResponse(apiType: APIType.aGet, url: likedFeedsURL + artistId);
    ModelLikedFeedResponse result = ModelLikedFeedResponse.fromJson(response);

    return result;
  }
}
