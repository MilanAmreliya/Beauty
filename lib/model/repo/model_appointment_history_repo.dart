import 'package:beuty_app/model/apiModel/responseModel/model_appointment_history_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class ModelAppointmentHistoryRepo extends BaseService {
  Future<ModelAppointmentHistoryResponse> modelAppointmentHistoryRepo() async {
    String modelId = PreferenceManager.getArtistId().toString();
    print('modelId=>$modelId');
    var response = await ApiService().getResponse(
        apiType: APIType.aGet, url: modelAppointmentHistoryURL + modelId);
    ModelAppointmentHistoryResponse result =
        ModelAppointmentHistoryResponse.fromJson(response);

    return result;
  }
}
