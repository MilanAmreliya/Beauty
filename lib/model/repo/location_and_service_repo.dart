
import 'package:beuty_app/model/apiModel/responseModel/toplocationandservice_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class LocationAndServiceRepo extends BaseService {
  Future<dynamic> locationAndServiceRepo() async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aGet, url: locationsAndServiceURL);
    LocationAndServiceResponse locationAndServiceResponse =
        LocationAndServiceResponse.fromJson(response);

    return locationAndServiceResponse;
  }
}
