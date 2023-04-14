import 'dart:developer';

import 'package:beuty_app/model/apiModel/requestModel/update_service_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/update_service_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:get/get.dart';

class UpdateServiceRepo extends BaseService {
  HomeTabViewModel controller = Get.find();
  Future<UpdateServiceResponse> updateServiceRepo(
      UpdateServiceReqModel model) async {
    Map<String, dynamic> body = await model.toJson();
    String serviceId = controller.serviceId.value;
    log("REQUEST UPDATE SERVICE---> $body");
    var response = await ApiService().getResponse(
        apiType: APIType.aPost,
        url: updateServiceURL + serviceId,
        body: body,
        fileUpload: true);
    print("responcce==>$response");
    UpdateServiceResponse result = UpdateServiceResponse.fromJson(response);
    return result;
  }
}
