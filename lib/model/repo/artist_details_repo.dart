import 'dart:convert';

import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_artist_allstory_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_category_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class GetArtistProfileDetailRepo extends BaseService {
  Future<ArtistProfileDetailResponse> getArtistDetails(String id) async {
    String artistId = id ?? PreferenceManager.getArtistId().toString();

    var response = await ApiService().getResponse(
        apiType: APIType.aGet, url: artistProfileDetailURL + artistId);
    ArtistProfileDetailResponse result =
        ArtistProfileDetailResponse.fromJson(response);

    return result;
  }
}
