import 'package:beuty_app/model/apiModel/requestModel/create_post_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/create_story_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/promoted_shop_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:dio/dio.dart';

class PromotedShopRepo extends BaseService {
  Future<PostSuccessResponse> promotedShop(
      PromotedShopRequestModel model) async {
    var response = await ApiService().getResponse(
        apiType: APIType.aPost,
        url: promotedURL,
        body: model.toJson(),
        fileUpload: true);
    PostSuccessResponse result = PostSuccessResponse.fromJson(response);
    return result;
  }
}
