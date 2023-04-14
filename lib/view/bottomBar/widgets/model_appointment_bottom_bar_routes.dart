import 'package:beuty_app/view/Appointment/modal_appointment.dart';
import 'package:beuty_app/view/commanScreen/chats/chat_user_list.dart';
import 'package:beuty_app/view/profileTab/following/following_screen.dart';
import 'package:flutter/material.dart';

Widget modelAppointmentBottomBarRoutes(String route) {
  switch (route) {
    case 'AppointmentScreen':
      return ModalAppointmentScreen();
      break;

    case 'FollowingScreen':
      return FollowingScreen();
      break;
    case 'UserListChat':
      return UserListChat(
        previousRoute: 'AppointmentScreen',
      );
      break;

    default:
      return ModalAppointmentScreen();
      break;
  }
}
