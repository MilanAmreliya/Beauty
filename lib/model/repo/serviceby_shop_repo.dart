
import 'package:beuty_app/model/apiModel/responseModel/service_by_shop_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class ServiceByShopRepo extends BaseService {
  Future<ServiceByShopResponse> serviceByShopRepo() async {
    String shopId = PreferenceManager.getShopId().toString();
    print('Shopid.........=>$shopId');
    var response = await ApiService()
        .getResponse(apiType: APIType.aGet, url: serviceByShopURL + shopId);
    print("service by shop...$response");
    ServiceByShopResponse result = ServiceByShopResponse.fromJson(response);

    return result;
  }
}
