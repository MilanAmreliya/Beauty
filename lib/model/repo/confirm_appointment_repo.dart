import 'package:beuty_app/model/apiModel/responseModel/confirm_appointment_response_,model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class ConfirmAppointmentRepo extends BaseService {
  Future<ConfirmAppointmentResponse> confirmAppointment(
      String appointmentId) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$confirmAppointmentURL$appointmentId',
    );
    ConfirmAppointmentResponse result =
        ConfirmAppointmentResponse.fromJson(response);
    return result;
  }
}
