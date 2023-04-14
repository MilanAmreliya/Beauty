import 'package:beuty_app/model/apiModel/requestModel/find_shop_by_filter_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/find_shop_by_filter_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/home_screen_feed_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class FindShopByFilterRepo extends BaseService {
  Future<HomeScreenFeedResponse> findShopByFilterRepo(
      FindShopByFilterReqModel model) async {
    print('request:${model.toJson()}');
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: findShopByFilterURL,
      body: model.toJson(),
    );
    print("response;;;;;;;;;;>$response");
    HomeScreenFeedResponse result =
        HomeScreenFeedResponse.fromJson(response);
    return result;
  }
}
