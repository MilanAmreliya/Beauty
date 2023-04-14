import 'package:beuty_app/model/apiModel/responseModel/cancel_aapointment_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class CancelAppointmentRepo extends BaseService {
  Future<CancelAppointmentResponse> cancelAppointment(String appointmentId) async {

    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$cancelAppointmentURL$appointmentId',
    );
    CancelAppointmentResponse result = CancelAppointmentResponse.fromJson(response);
    return result;
  }
}
