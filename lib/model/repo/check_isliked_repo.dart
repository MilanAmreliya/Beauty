import 'package:beuty_app/model/apiModel/responseModel/check_isliked_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class CheckIsLikedRepo extends BaseService {
  Future<CheckIsLikedResponse> checkIsLiked(String postId,
      ) async {
    // String artistId = '54';
    String id =  PreferenceManager.getArtistId().toString();

    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$checkIsLikedURL$id/$postId',
    );
    CheckIsLikedResponse result = CheckIsLikedResponse.fromJson(response);
    return result;
  }
}
