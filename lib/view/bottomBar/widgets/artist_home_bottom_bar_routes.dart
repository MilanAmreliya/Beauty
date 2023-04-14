import 'package:beuty_app/view/commanScreen/chats/chat_user_list.dart';
import 'package:beuty_app/view/commanScreen/editStory/edit_story.dart';
import 'package:beuty_app/view/commanScreen/newStory/new_story.dart';
import 'package:beuty_app/view/commanScreen/sharePost/share_post.dart';
import 'package:beuty_app/view/commanScreen/shareStory/share_story.dart';
import 'package:beuty_app/view/commanScreen/viewStory/view_story.dart';
import 'package:beuty_app/view/homeTab/home/home.dart';
import 'package:beuty_app/view/homeTab/profile_post/profile-post_screen.dart';
import 'package:beuty_app/view/homeTab/shopFilterData/shop_filter_data_screen.dart';
import 'package:beuty_app/view/profileTab/allPosts/edit_post.dart';
import 'package:beuty_app/view/singlePostScreen/single_post_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:beuty_app/view/homeTab/search_user/search_screen.dart';
import 'package:beuty_app/view/comments/view_all_comments.dart';

Widget artistHomeBottomBarRoutes(
  String route,
) {
  switch (route) {
    case 'HomeScreen':
      return HomeScreen(
        role: 'Artist',
      );
      break;
    case 'ViewStory':
      return ViewStory(
        previousRoute: 'HomeScreen',
      );
      break;

    ///single post screen for home screen

    case 'SinglePostScreen':
      return SinglePostScreen(
        previousRoute: 'HomeScreen',
      );
      break;

    case 'EditPostScreen':
      return EditPostScreen();
      break;

    ///single post screen for profile post screen

    case 'SinglePostProfilePostScreen':
      return SinglePostScreen(
        previousRoute: 'ProfilePostScreen',
      );
      break;

    /// profile post

    case 'ProfilePostScreen':
      return ProfilePostScreen(
        singlePostScreenRoute: "SinglePostProfilePostScreen",
        previousRoute: "HomeScreen",
      );
      break;

    ///single post screen for filter data profile post screen

    case 'SinglePostFilterDataScreen':
      return SinglePostScreen(
        previousRoute: 'FilterProfilePostScreen',
      );
      break;

    ///profile post screen for filter data screen

    case 'FilterProfilePostScreen':
      return ProfilePostScreen(
        singlePostScreenRoute: "SinglePostFilterDataScreen",
        previousRoute: "FilterShopDataScreen",
      );
      break;
    case 'NewStory':
      return NewStory();
      break;
    case 'SearchScreen':
      return SearchScreen();
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
    case 'EditPostScreen':
      return EditPostScreen();
      break;
    case 'FilterShopDataScreen':
      return FilterShopDataScreen(
        role: 'Artist',
      );
      break;
    case 'UserListChat':
      return UserListChat(
        previousRoute: 'HomeScreen',
      );
      break;
    case 'ViewAllComments':
      return ViewAllComments();
      break;
    default:
      return HomeScreen(
        role: 'Artist',
      );
      break;
  }
}
