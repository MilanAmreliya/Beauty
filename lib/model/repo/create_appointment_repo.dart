import 'dart:developer';

import 'package:beuty_app/model/apiModel/requestModel/create_appoinment_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/create_appointment_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class CreateAppointmentRepo extends BaseService {
  Future<CreateAppointmentResponse> createAppointment(
      CreateAppointmentReq model) async {
    Map<String, dynamic> body = await model.toJson();
    log("REQUEST APPONMNTMENT $body");
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: createAppointmentURL,
      body: body,
    );
    CreateAppointmentResponse createAppointmentResponse =
        CreateAppointmentResponse.fromJson(response);
    return createAppointmentResponse;
  }
}
