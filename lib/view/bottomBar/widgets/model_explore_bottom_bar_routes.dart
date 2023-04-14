import 'package:beuty_app/view/Appointment/booking.dart';
import 'package:beuty_app/view/commanScreen/chats/chat_user_list.dart';
import 'package:beuty_app/view/commanScreen/tagged/tagged_screen.dart';
import 'package:beuty_app/view/commanScreen/viewStory/view_story.dart';
import 'package:beuty_app/view/exploreTab/categoryScreen/categoryScreen.dart';
import 'package:beuty_app/view/exploreTab/explore/explore_screen.dart';
import 'package:beuty_app/view/homeTab/shopFilterData/shop_filter_data_screen.dart';
import 'package:beuty_app/view/modelProfilePostScreen/model_profile-post_screen.dart';
import 'package:beuty_app/view/singlePostScreen/single_post_view_screen.dart';
import 'package:flutter/material.dart';

Widget modelExploreBottomBarRoutes(String route) {
  switch (route) {
    case 'ExploreScreen':
      return ExploreScreen(
        role: 'Model',
      );
      break;
    case 'ViewStory':
      return ViewStory(
        previousRoute: 'ExploreScreen',
      );
      break;
    case 'TaggedScreen':
      return TaggedScreen();
      break;
    case 'CategoryScreen':
      return CategoryScreen(
        role: 'Model',
      );
      break;
    case 'UserListChat':
      return UserListChat(
        previousRoute: 'ExploreScreen',
      );
      break;
    case 'FilterShopDataScreen':
      return FilterShopDataScreen(
        role: "Model"
      );
      break;
    case 'SinglePostScreen':
      return SinglePostScreen(
        previousRoute: 'ModelProfilePostScreen',
      );
      break;
    case 'FilterModelProfilePostScreen':
      return ModelProfilePostScreen(
        previousRoute: "FilterShopDataScreen",
        singlePostScreen: "SinglePostScreen",
      );
      break;
    case 'BookAppointmentScreen':
      return BookAppointmentScreen();
      break;

    default:
      return ExploreScreen(
        role: "Model",
      );
      break;
  }
}
