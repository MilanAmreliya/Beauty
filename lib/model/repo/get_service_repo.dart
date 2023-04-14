import 'package:beuty_app/model/apiModel/responseModel/get_service_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class GetServiceRepo extends BaseService {
  Future<dynamic> getServiceRepo(String serviceId) async {
    String url = getServiceURL + serviceId;
    print("serviceId.....$serviceId");
    print("getServiceURL.....$url");

    var response =
        await ApiService().getResponse(apiType: APIType.aGet, url: url);
    print("responce=>.....$response");
    GetServiceResponse getServiceResponse =
        GetServiceResponse.fromJson(response);

    return getServiceResponse;
  }
}
