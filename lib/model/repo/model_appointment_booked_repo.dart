import 'package:beuty_app/model/apiModel/responseModel/model_appointment_booked_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class ModelAppointmentBookedRepo extends BaseService {
  Future<ModelAppointmentBookedResponse> modelAppointmentBookedRepo() async {
    String modelId = PreferenceManager.getArtistId().toString();
    print('modelId=>$modelId');
    var response = await ApiService().getResponse(
        apiType: APIType.aGet, url: modelAppointmentBookedURL + modelId);
    ModelAppointmentBookedResponse result =
        ModelAppointmentBookedResponse.fromJson(response);

    return result;
  }
}
