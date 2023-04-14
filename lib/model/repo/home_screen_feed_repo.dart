import 'package:beuty_app/model/apiModel/responseModel/home_screen_feed_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class GetHomeScreenFeedRepo extends BaseService {
  Future<HomeScreenFeedResponse> getHomeScreenFeed(
      {String lat, String long}) async {
    String currentId = PreferenceManager.getArtistId().toString();
    var response = await ApiService().getResponse(
        apiType: APIType.aGet, url: getHomeFeedURL + '$lat/$long/' + currentId);

    print("home responce=>$response");
    HomeScreenFeedResponse result = HomeScreenFeedResponse.fromJson(response);
    print(result);
    return result;
  }
}
