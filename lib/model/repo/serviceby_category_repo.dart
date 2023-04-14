import 'package:beuty_app/model/apiModel/responseModel/serviceby_category_reponse_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class ServiceByCategoryrepo extends BaseService {
  Future<ServiceByCategoryResponse> serviceByCategoryRepo(
      String categoryId) async {
    print('id...=>$categoryId');
    var response = await ApiService().getResponse(
        apiType: APIType.aGet, url: serviceByCategoryURL + categoryId);
    ServiceByCategoryResponse result =
        ServiceByCategoryResponse.fromJson(response);

    return result;
  }
}
