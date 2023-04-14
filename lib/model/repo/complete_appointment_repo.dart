import 'package:beuty_app/model/apiModel/requestModel/check_user_exist_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/complete_appointment_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class CompleteAppointmentRepo extends BaseService {
  Future<CompleteAppointmentResponse> completeAppointment(
      String appointmentId) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: completeAppointmentURL + appointmentId,
    );
    CompleteAppointmentResponse result =
        CompleteAppointmentResponse.fromJson(response);
    return result;
  }
}
