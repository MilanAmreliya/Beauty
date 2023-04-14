import 'dart:developer';

import 'package:beuty_app/model/apiModel/responseModel/shop_sales_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class ShopSalesRepo extends BaseService {
  Future<ShopSalesResponse> shopSales() async {
    String shopId = PreferenceManager.getShopId().toString();
    print(' ShopSalesRepo id=>111$shopId');
    if (shopId == null) {
      return null;
    }
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: shopSalesURL + shopId,
    );
    log('ShopSalesRepo response :$response');

    ShopSalesResponse result = ShopSalesResponse.fromJson(response);
    return result;
  }
}
