import 'package:beuty_app/view/Appointment/booking.dart';
import 'package:beuty_app/view/Appointment/modal_appointment.dart';
import 'package:beuty_app/view/commanScreen/chats/chat_user_list.dart';
import 'package:beuty_app/view/commanScreen/editStory/edit_story.dart';
import 'package:beuty_app/view/commanScreen/newStory/new_story.dart';
import 'package:beuty_app/view/commanScreen/sharePost/share_post.dart';
import 'package:beuty_app/view/commanScreen/shareStory/share_story.dart';
import 'package:beuty_app/view/commanScreen/viewStory/view_story.dart';
import 'package:beuty_app/view/homeTab/home/home.dart';
import 'package:beuty_app/view/homeTab/profile_post/profile-post_screen.dart';
import 'package:beuty_app/view/homeTab/search_user/search_screen.dart';
import 'package:beuty_app/view/homeTab/shopFilterData/shop_filter_data_screen.dart';
import 'package:beuty_app/view/modelProfilePostScreen/model_profile-post_screen.dart';
import 'package:beuty_app/view/comments/view_all_comments.dart';
import 'package:beuty_app/view/singlePostScreen/single_post_view_screen.dart';

import 'package:flutter/material.dart';

Widget modelHomeBottomBarRoutes(
  String route,
) {
  switch (route) {
    case 'HomeScreen':
      return HomeScreen(
        role: 'Model',
      );
      break;
    case 'ViewStory':
      return ViewStory(
        previousRoute: 'HomeScreen',
      );
      break;
    case 'NewStory':
      return NewStory();
      break;
    case 'EditStory':
      return EditStory();
      break;
    case 'ShareStory':
      return ShareStory();
      break;
    case 'SharePost':
      return SharePost();
      break;

    case 'BookAppointmentScreen':
      return BookAppointmentScreen();
      break;
    case 'UserListChat':
      return UserListChat(
        previousRoute: 'HomeScreen',
      );
      break;
    case 'SearchScreen':
      return SearchScreen();
      break;
    case 'FilterShopDataScreen':
      return FilterShopDataScreen(
        role: "Model"
      );
      break;
    case 'ViewAllComments':
      return ViewAllComments();
      break;
    case 'AppointmentScreen':
      return ModalAppointmentScreen();
      break;

    ///single post for model home screen
    case 'SinglePostScreen':
      return SinglePostScreen(
        previousRoute: 'HomeScreen',
      );
      break;

    ///single post for model profile post screen
    case 'SinglePostModelProfilePostScreen':
      return SinglePostScreen(
        previousRoute: 'ModelProfilePostScreen',
      );
      break;

    /// model profile post screen
    case 'ModelProfilePostScreen':
      return ModelProfilePostScreen(
        previousRoute: "HomeScreen",
        singlePostScreen: "SinglePostModelProfilePostScreen",
      );
      break;

    ///single post for model filter shop screen
    case 'SinglePostModelFilterDataScreen':
      return SinglePostScreen(
        previousRoute: 'FilterModelProfilePostScreen',
      );
      break;

    /// model profile post screen
    case 'FilterModelProfilePostScreen':
      return ModelProfilePostScreen(
        previousRoute: "FilterShopDataScreen",
        singlePostScreen: "SinglePostModelFilterDataScreen",
      );
      break;

    default:
      return HomeScreen(
        role: 'Model',
      );
      break;
  }
}
