
import 'package:beuty_app/model/apiModel/responseModel/get_all_users_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class GetAllUsersRepo extends BaseService {
  Future<GetAllUsersResponse> getAllUsers() async {
    String currentId = PreferenceManager.getArtistId().toString();

    var response = await ApiService()
        .getResponse(apiType: APIType.aGet, url: getAllUsersURL+currentId);
    GetAllUsersResponse result = GetAllUsersResponse.fromJson(response);

    return result;
  }
}
