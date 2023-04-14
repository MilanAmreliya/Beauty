import 'package:beuty_app/view/commanScreen/chats/chat_user_list.dart';
import 'package:beuty_app/view/commanScreen/tagged/tagged_screen.dart';
import 'package:beuty_app/view/commanScreen/viewStory/view_story.dart';
import 'package:beuty_app/view/exploreTab/categoryScreen/categoryScreen.dart';
import 'package:beuty_app/view/exploreTab/explore/explore_screen.dart';
import 'package:beuty_app/view/homeTab/profile_post/profile-post_screen.dart';
import 'package:beuty_app/view/homeTab/shopFilterData/shop_filter_data_screen.dart';
import 'package:beuty_app/view/singlePostScreen/single_post_view_screen.dart';
import 'package:flutter/material.dart';

Widget artistExploreBottomBarRoutes(String route) {
  switch (route) {
    case 'ExploreScreen':
      return ExploreScreen(
        role: 'Artist',
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
        role: 'Artist',
      );
      break;
    case 'FilterShopDataScreen':
      return FilterShopDataScreen(
        role: 'Artist',
      );
      break;
    case 'SinglePostScreen':
      return SinglePostScreen(
        previousRoute: "FilterProfilePostScreen",
      );
      break;
    case 'FilterProfilePostScreen':
      return ProfilePostScreen(
        singlePostScreenRoute: "SinglePostScreen",
        previousRoute: "FilterShopDataScreen",
      );
      break;
    case 'UserListChat':
      return UserListChat(
        previousRoute: 'ExploreScreen',
      );
      break;

    default:
      return ExploreScreen(
        role: 'Artist',
      );
      break;
  }
}
