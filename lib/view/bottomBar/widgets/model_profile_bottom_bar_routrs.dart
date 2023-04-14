import 'package:beuty_app/view/commanScreen/chats/chat_user_list.dart';
import 'package:beuty_app/view/modalProfile/model_profile_screen.dart';
import 'package:beuty_app/view/profileTab/following/following_screen.dart';
import 'package:beuty_app/view/singlePostScreen/single_post_view_screen.dart';
import 'package:flutter/material.dart';

Widget modelProfileBottomBarRoutes(String route) {
  switch (route) {
    case 'ModalProfileScreen':
      return ModalProfileScreen();
      break;
    case 'SinglePostScreen':
      return SinglePostScreen(
        previousRoute: 'ModalProfileScreen',
      );
      break;

    case 'FollowingScreen':
      return FollowingScreen();
      break;
    case 'UserListChat':
      return UserListChat(
        previousRoute: 'ModalAppointmentScreen',
      );
      break;
    case 'SinglePostScreen':
      return SinglePostScreen(
        previousRoute: 'HomeScreen',
      );
      break;
    default:
      return ModalProfileScreen();
      break;
  }
}
