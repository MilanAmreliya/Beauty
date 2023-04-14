import 'package:beuty_app/model/apiModel/requestModel/follow_person_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class FollowPersonRepo extends BaseService {
  Future<PostSuccessResponse> followPerson(
      FollowPersonRequestModel model) async {
    print('re=>${model.toJson()}');
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: followPersonURL,
      body: model.toJson(),
    );
    PostSuccessResponse result = PostSuccessResponse.fromJson(response);
    return result;
  }
}
