
import 'package:beuty_app/model/apiModel/responseModel/get_artist_allstory_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class GetArtistAllStoryRepo extends BaseService {
  Future<dynamic> getArtistStory({String lat, String long}) async {
    String currentUser = PreferenceManager.getArtistId().toString();
    print('CurrentId:$currentUser');
    var response = await ApiService().getResponse(
        apiType: APIType.aGet,
        url: getAllStoryURL + '$lat/$long/' + currentUser);
    print("==================get=====story==${getAllStoryURL + '$lat/$long/' + currentUser}");
    GetArtistAllStoryResponse getArtistAllStoryResponse =
        GetArtistAllStoryResponse.fromJson(response);

    return getArtistAllStoryResponse;
  }
}
