import 'package:flutter/material.dart';
import 'package:get/get.dart';

titleForAppointmentScreen({String currentAppointmentStatus,Function onTap}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        "Appointment",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: Get.height / 30,
            fontFamily: 'Poppins'),
      ),
      Text(
        currentAppointmentStatus,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: Get.height / 50,
            fontFamily: 'Poppins'),
      ),
    ],
  );
}
