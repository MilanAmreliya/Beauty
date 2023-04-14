import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/model/apiModel/responseModel/cancel_aapointment_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/confirm_appointment_response_,model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/appointment_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> appointmentRequestConfirmDialog(String appointmentId) async {
  return Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.calendar_today,
            color: cRoyalBlue,
            size: 50,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Are you sure you want accept?'),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              customBtn(
                  title: 'Cancel',
                  radius: 50,
                  width: 100,
                  height: 35,
                  onTap: () async {
                    await cancelAppointment(appointmentId);
                    Get.back();
                  }),
              customBtn(
                  title: 'Confirm',
                  radius: 50,
                  width: 100,
                  height: 35,
                  onTap: () async {
                    await confirmAppointment(appointmentId);
                    Get.back();
                  }),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
  );
}

Future<void> cancelAppointment(String appointmentId) async {
  AppointmentViewModel viewModel = Get.find();
  await viewModel.cancelAppointment(appointmentId);
  if (viewModel.cancelAppointmentApiResponse.status == Status.COMPLETE) {
    CancelAppointmentResponse response =
        viewModel.cancelAppointmentApiResponse.data;
    if (response.message == "Appointment cancelled") {
      CommanWidget.snackBar(message: response.message);
      await viewModel.artistPendingAppointment();

      Get.back();
    } else {
      CommanWidget.snackBar(message: 'Appointment not cancel plz try again');
    }
  } else {
    CommanWidget.snackBar(message: 'Server Error');
  }
}

Future<void> confirmAppointment(String appointmentId) async {
  AppointmentViewModel viewModel = Get.find();
  await viewModel.confirmAppointment(appointmentId);
  if (viewModel.confirmAppointmentApiResponse.status == Status.COMPLETE) {
    ConfirmAppointmentResponse response =
        viewModel.confirmAppointmentApiResponse.data;
    if (response.message == "Appointment approved") {
      CommanWidget.snackBar(message: response.message);
      await viewModel.artistPendingAppointment();
      await viewModel.getBookedAppointment();
      Get.back();
    } else {
      CommanWidget.snackBar(message: 'Appointment not cancel plz try again');
    }
  } else {
    CommanWidget.snackBar(message: 'Server Error');
  }
}
