
import 'package:beuty_app/model/apiModel/responseModel/home_artist_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class GetHomeArtistRepo extends BaseService {
  Future<HomeArtistResponse> getHomeRepo() async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aGet, url: homeArtistURL);

    print("home responce=>$response");
    HomeArtistResponse result = HomeArtistResponse.fromJson(response);
    print(result);
    return result;
  }
}
