
import 'package:beuty_app/model/apiModel/responseModel/artist_post_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class GetArtistPostRepo extends BaseService {
  Future<dynamic> getArtistPost(String artistId) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aGet, url: getArtistPostURL + artistId);
    ArtistPostResponse result = ArtistPostResponse.fromJson(response);

    return result;
  }
}
