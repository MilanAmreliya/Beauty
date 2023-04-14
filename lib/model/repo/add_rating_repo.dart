import 'package:beuty_app/model/apiModel/requestModel/add_rating_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/add_rating_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class AddRatingRepo extends BaseService {
  Future<AddRatingResponse> addRatingRepo(AddRateReqModel model) async {
    Map<String, dynamic> body = await model.toJson();

    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: putReviewURL,
      body: body,
    );
    print("responcce==>$response");
    print("Body request Add services.  ==> $body");
    AddRatingResponse result = AddRatingResponse.fromJson(response);
    return result;
  }
}
