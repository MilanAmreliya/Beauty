
import 'package:beuty_app/model/apiModel/responseModel/delete_service_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class DeleteServiceRepo extends BaseService {
  Future<DeleteServiceResponse> deleteServiceRepo(String serviceId) async {
    String url = deleteServiceURL + serviceId;
    var response =
        await ApiService().getResponse(apiType: APIType.aGet, url: url);
    DeleteServiceResponse result = DeleteServiceResponse.fromJson(response);
    return result;
  }
}
