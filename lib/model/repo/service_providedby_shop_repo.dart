import 'package:beuty_app/model/apiModel/responseModel/service_providedby_shop_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class ServiceProvidedByShopRepo extends BaseService {
  Future<ServiceProviedByshopResponse> serviceProvidedByShopRepo(
      String shopId) async {
    var response = await ApiService().getResponse(
        apiType: APIType.aGet, url: serviceProviedByshopURL + shopId);
    ServiceProviedByshopResponse result =
        ServiceProviedByshopResponse.fromJson(response);

    return result;
  }
}
