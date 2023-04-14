import 'package:beuty_app/model/apiModel/responseModel/get_post_by_id_response.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class GetPostByArtistRepo extends BaseService {
  Future<GetPostByIdResponse> getPostByArtist() async {
    String artistId = PreferenceManager.getArtistId().toString();
    var response = await ApiService()
        .getResponse(apiType: APIType.aGet, url: getPostByArtistURL + artistId);
    GetPostByIdResponse getPostByIdResponse =
        GetPostByIdResponse.fromJson(response);

    return getPostByIdResponse;
  }
}
