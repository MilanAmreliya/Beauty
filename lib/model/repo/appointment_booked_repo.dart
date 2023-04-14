import 'package:beuty_app/model/apiModel/responseModel/artist_appointment_booked_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class GetAppointmentBookedRepo extends BaseService {
  Future<ArtistAppointmentBookedResponse> appointmentBooked() async {
    String artistId = PreferenceManager.getArtistId().toString();
    print('artistId=>$artistId');
    var response = await ApiService().getResponse(
        apiType: APIType.aGet, url: artistAppointmentBookedURL + artistId);
    ArtistAppointmentBookedResponse result =
        ArtistAppointmentBookedResponse.fromJson(response);

    return result;
  }
}
