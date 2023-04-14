import 'package:beuty_app/model/apiModel/responseModel/model_appointment_pending_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class ModelAppointmentPendingRepo extends BaseService {
  Future<ModelAppointmentPendingResponse> modelAppointmentPendingRepo() async {
    String modelId = PreferenceManager.getArtistId().toString();
    print('modelId=>$modelId');
    var response = await ApiService().getResponse(
        apiType: APIType.aGet, url: modelAppointmentPendingURL + modelId);
    ModelAppointmentPendingResponse result =
        ModelAppointmentPendingResponse.fromJson(response);

    return result;
  }
}
