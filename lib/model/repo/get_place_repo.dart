
import 'package:beuty_app/model/apiModel/responseModel/get_place.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class GetPlaceRepo extends BaseService {
  Future<GetPlaceResponse> getPlace() async {
    var response =
        await ApiService().getResponse(apiType: APIType.aGet, url: allPlaceUrl);
    GetPlaceResponse result = GetPlaceResponse.fromJson(response);

    return result;
  }
}
