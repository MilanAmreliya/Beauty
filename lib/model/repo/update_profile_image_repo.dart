import 'package:beuty_app/model/apiModel/requestModel/update_profile_image_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/update_profile_image_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class UpdateProfileImageRepo extends BaseService {
  Future<UpdateProfileImageResponse> updateProfileImageRepo(
      UpdateProfileImageReqModel model) async {
    Map<String, dynamic> body = await model.toJson();
    String artistId = PreferenceManager.getArtistId().toString();
    var response = await ApiService().getResponse(
        apiType: APIType.aPost,
        url: updateUserPhotoURL + artistId,
        body: body,
        fileUpload: true);
    print("responcce==>$response");
    UpdateProfileImageResponse result =
        UpdateProfileImageResponse.fromJson(response);
    return result;
  }
}
