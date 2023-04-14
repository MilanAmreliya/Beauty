import 'package:beuty_app/model/apiModel/requestModel/change_password_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class ChangePasswordRepo extends BaseService {
  String currentUserId = PreferenceManager.getArtistId().toString();

  Future<PostSuccessResponse> changePassword(
      ChangePasswordReqModel model) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: changePasswordURL + currentUserId,
      body: model.toJson(),
    );
    PostSuccessResponse result = PostSuccessResponse.fromJson(response);
    return result;
  }
}
