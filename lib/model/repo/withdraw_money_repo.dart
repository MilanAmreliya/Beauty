import 'package:beuty_app/model/apiModel/requestModel/withdraw_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/withdraw_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class WithdrawMoneyRepo extends BaseService {
  Future<WithdrawMoneyResponse> withdrawMoneyRepo(
      WithdrawReqModel model) async {
    print('req :${model.toJson()}');
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: createWithdrawURL,
      body: model.toJson(),
    );
    print("WithdrawMoneyResponse responcce==>$response");
    WithdrawMoneyResponse result = WithdrawMoneyResponse.fromJson(response);
    return result;
  }
}
