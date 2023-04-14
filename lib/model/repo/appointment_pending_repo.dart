import 'dart:developer';

import 'package:beuty_app/model/apiModel/responseModel/artist_appointment_pending_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';

class ArtistAppointmentPendingRepo extends BaseService {
  Future<ArtistAppointmentPendingResponse> appointmentPendingRepo() async {
    String artistId = PreferenceManager.getArtistId().toString();
    log("Login user id ---> $artistId");
    var response = await ApiService().getResponse(
        apiType: APIType.aGet, url: artistAppointmentPendingURL + artistId);
    ArtistAppointmentPendingResponse result =
        ArtistAppointmentPendingResponse.fromJson(response);

    return result;
  }
}
