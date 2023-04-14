import 'package:beuty_app/model/apiModel/requestModel/create_appoinment_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_appointment_booked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_appointment_history_repponse_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_appointment_pending_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/cancel_aapointment_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/confirm_appointment_response_,model.dart';
import 'package:beuty_app/model/apiModel/responseModel/create_appointment_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/model_appointment_booked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/model_appointment_history_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/model_appointment_pending_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/model/repo/appointment_booked_repo.dart';
import 'package:beuty_app/model/repo/appointment_history_repo.dart';
import 'package:beuty_app/model/repo/appointment_pending_repo.dart';
import 'package:beuty_app/model/repo/cancel_appointment_repo.dart';
import 'package:beuty_app/model/repo/confirm_appointment_repo.dart';
import 'package:beuty_app/model/repo/create_appointment_repo.dart';
import 'package:beuty_app/model/repo/model_appointment_booked_repo.dart';
import 'package:beuty_app/model/repo/model_appointment_history_repo.dart';
import 'package:beuty_app/model/repo/model_appointment_pending_repo.dart';
import 'package:get/get.dart';
import 'package:beuty_app/model/apiModel/responseModel/complete_appointment_response_model.dart';
import 'package:beuty_app/model/repo/complete_appointment_repo.dart';

class AppointmentViewModel extends GetxController {
  ApiResponse bookedAppointmentApiResponse = ApiResponse.initial('Initial');
  ApiResponse modelBookedAppointmentApiResponse =
      ApiResponse.initial('Initial');
  ApiResponse historyAppointmentApiResponse = ApiResponse.initial('Initial');
  ApiResponse artistPendingAppointmentApiResponse =
      ApiResponse.initial('Initial');
  ApiResponse pendingAppointmentApiResponse = ApiResponse.initial('Initial');
  ApiResponse completeAppointmentRepoApiResponse =
      ApiResponse.initial('Initial');
  ApiResponse modelHistoryAppointmentApiResponse =
      ApiResponse.initial('Initial');
  ApiResponse cancelAppointmentApiResponse = ApiResponse.initial('Initial');
  ApiResponse confirmAppointmentApiResponse = ApiResponse.initial('Initial');
  ApiResponse createAppointmentApiResponse = ApiResponse.initial('Initial');
  ApiResponse appointmentByArtistCurrentApiResponse =
      ApiResponse.initial('Initial');

/*

  RxString _paymentType = ''.obs;

  RxString get paymentType => _paymentType;

  void setPaymentType(String value) {
    _paymentType = value.obs;
    update();
  }
*/

  ///Get Booked Appointment...
  Future<void> getBookedAppointment() async {
    bookedAppointmentApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ArtistAppointmentBookedResponse response =
          await GetAppointmentBookedRepo().appointmentBooked();
      print('bookedAppointmentApiResponse${response}');
      bookedAppointmentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("bookedAppointmentApiResponse Error.........>$e");
      bookedAppointmentApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Get History Appointment...
  Future<void> getHistoryAppointment() async {
    historyAppointmentApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ArtistAppointmentHistoryResponse response =
          await GetAppointmentHistoryRepo().appointmentHistory();
      historyAppointmentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("historyAppointmentApiResponse 1.........>$e");
      historyAppointmentApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Artist Pending Appointment...
  Future<void> artistPendingAppointment() async {
    artistPendingAppointmentApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ArtistAppointmentPendingResponse response =
          await ArtistAppointmentPendingRepo().appointmentPendingRepo();
      artistPendingAppointmentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("historyAppointmentApiResponse 2.........>$e");
      artistPendingAppointmentApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Get Cancel Appointment...
  Future<void> cancelAppointment(String appointmentId) async {
    cancelAppointmentApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      CancelAppointmentResponse response =
          await CancelAppointmentRepo().cancelAppointment(appointmentId);
      cancelAppointmentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("cancelAppointmentApiResponse .........>$e");
      cancelAppointmentApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Get Confirm Appointment...
  Future<void> confirmAppointment(String appointmentId) async {
    confirmAppointmentApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ConfirmAppointmentResponse response =
          await ConfirmAppointmentRepo().confirmAppointment(appointmentId);
      confirmAppointmentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("confirmAppointmentApiResponse .........>$e");
      confirmAppointmentApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///create appointment...
  Future<void> createAppointment(CreateAppointmentReq model) async {
    createAppointmentApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      CreateAppointmentResponse response =
          await CreateAppointmentRepo().createAppointment(model);
      createAppointmentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      createAppointmentApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Model Booked Appointment...
  Future<void> modelBookedAppointment() async {
    modelBookedAppointmentApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ModelAppointmentBookedResponse response =
          await ModelAppointmentBookedRepo().modelAppointmentBookedRepo();
      print('response:${response}');
      modelBookedAppointmentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("modelBookedAppointmentApiResponse .........>$e");
      modelBookedAppointmentApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///model History Appointment...
  Future<void> modelHistoryAppointment() async {
    modelHistoryAppointmentApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ModelAppointmentHistoryResponse response =
          await ModelAppointmentHistoryRepo().modelAppointmentHistoryRepo();
      modelHistoryAppointmentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("historyAppointmentApiResponse 2.........>$e");
      modelHistoryAppointmentApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///model Pending Appointment...
  Future<void> modelPendingAppointment() async {
    pendingAppointmentApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ModelAppointmentPendingResponse response =
          await ModelAppointmentPendingRepo().modelAppointmentPendingRepo();
      pendingAppointmentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("pendingAppointmentApiResponse .........>$e");
      pendingAppointmentApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///compete Appointment after payment
  Future<void> completeAppointment(String appointmentId) async {
    completeAppointmentRepoApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      CompleteAppointmentResponse response =
          await CompleteAppointmentRepo().completeAppointment(appointmentId);
      completeAppointmentRepoApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("completeAppointmentRepoApiResponse .........>$e");
      completeAppointmentRepoApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
