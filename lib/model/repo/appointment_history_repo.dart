import 'package:beuty_app/model/apiModel/responseModel/artist_appointment_history_repponse_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class GetAppointmentHistoryRepo extends BaseService {
  Future<ArtistAppointmentHistoryResponse> appointmentHistory() async {
    String artistId = PreferenceManager.getArtistId().toString();
    var response = await ApiService().getResponse(
        apiType: APIType.aGet, url: artistAppointmentHistoryURL + artistId);
    ArtistAppointmentHistoryResponse result =
        ArtistAppointmentHistoryResponse.fromJson(response);

    return result;
  }
}
