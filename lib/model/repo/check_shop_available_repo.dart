import 'package:beuty_app/model/apiModel/responseModel/check_shop_available_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class CheckShopAvailableRepo extends BaseService {
  Future<CheckShopAvailableResponse> checkShopAvailable() async {
    String artistId = PreferenceManager.getArtistId().toString();
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: checkShopAvailableURL + artistId,
    );
    CheckShopAvailableResponse result =
        CheckShopAvailableResponse.fromJson(response);
    return result;
  }
}
