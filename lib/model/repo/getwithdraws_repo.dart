import 'package:beuty_app/model/apiModel/responseModel/get_withdraws_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class GetWithdrawsRepo extends BaseService {
  Future<GetWithdrawResponse> getWithdrawsRepo(String shopId) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aGet, url: getWithdrawsURL + shopId);
    GetWithdrawResponse result = GetWithdrawResponse.fromJson(response);

    return result;
  }
}
