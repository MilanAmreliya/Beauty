
import 'package:beuty_app/model/apiModel/responseModel/shopbalance_responce_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class ShopBalanceRepo extends BaseService {
  Future<ShopBalanceResponse> shopBalanceRepo() async {
    String shopId = PreferenceManager.getShopId().toString();
    print('id=>111$shopId');
    if(shopId==null){
      return null;
    }
    var response = await ApiService()
        .getResponse(apiType: APIType.aGet, url: shopBalanceURL + shopId);
    ShopBalanceResponse result = ShopBalanceResponse.fromJson(response);

    return result;
  }
}
