import 'package:beuty_app/model/apiModel/requestModel/update_profile_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/update_profile_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class UpdateProfileRepo extends BaseService {
  Future<UpdateProfileResponse> updateProfileRepo(
      UpdateProfileReqModel model) async {
    Map<String, dynamic> body = await model.toJson();
    String artistId = PreferenceManager.getArtistId().toString();
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: updateProfileURL + artistId,
      body: body,
    );
    print("responcce==>$response");
    UpdateProfileResponse result = UpdateProfileResponse.fromJson(response);
    return result;
  }
}
