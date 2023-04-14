
import 'package:beuty_app/view/commanScreen/chats/chat_user_list.dart';
import 'package:beuty_app/view/profileTab/appointment/appointment_screen.dart';
import 'package:flutter/material.dart';

Widget artistCameraBottomBarRoutes(
  String route,
) {
  switch (route) {
    case 'AppointmentScreen':
      return AppointmentScreen();
      break;
    case 'UserListChat':
      return UserListChat(
        previousRoute: 'AppointmentScreen',
      );
      break;
    default:
      return AppointmentScreen();
      break;
  }
}
