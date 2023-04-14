import 'package:beuty_app/view/commanScreen/chats/chat_user_list.dart';
import 'package:beuty_app/view/commanScreen/editStory/edit_story.dart';
import 'package:beuty_app/view/commanScreen/newStory/new_story.dart';
import 'package:beuty_app/view/commanScreen/sharePost/share_post.dart';
import 'package:beuty_app/view/commanScreen/shareStory/share_story.dart';
import 'package:beuty_app/view/profileTab/allPosts/all_posts.dart';
import 'package:beuty_app/view/profileTab/allPosts/edit_post.dart';
import 'package:beuty_app/view/profileTab/artistProfilePost/artist_profile_post_screen.dart';
import 'package:beuty_app/view/profileTab/artist_profile_services/artist_profile_services.dart';
import 'package:beuty_app/view/profileTab/balance/balance.dart';
import 'package:beuty_app/view/profileTab/balance/hair_cut.dart';
import 'package:beuty_app/view/profileTab/shopView/shop_view.dart';
import 'package:beuty_app/view/profileTab/shop_screen/add_service_screen.dart';
import 'package:beuty_app/view/profileTab/shop_screen/create_shop_screen.dart';
import 'package:beuty_app/view/profileTab/shop_screen/edit_service_screen.dart';
import 'package:beuty_app/view/profileTab/shop_screen/shop_screen.dart';
import 'package:beuty_app/view/profileTab/userProfile/user_profile_screen.dart';
import 'package:beuty_app/view/singlePostScreen/single_post_view_screen.dart';
import 'package:flutter/material.dart';

Widget artistProfileBottomBarRoutes(String route) {
  switch (route) {
    case 'UserProfileScreen':
      return UserProfileScreen();
      break;
    case 'Balance':
      return Balance();
      break;

    case 'CreateShopScreen':
      return CreateShopScreen();
      break;

    case 'ShopScreen':
      return ShopScreen();
      break;
    case 'AddServicesScreen':
      return AddServicesScreen();
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
    case 'UserListChat':
      return UserListChat(
        previousRoute: 'ArtistUserProfileScreen',
      );
      break;

    case 'HairCut':
      return HairCut();
      break;
    case 'ArtistUserProfileScreen':
      return ArtistUserProfileScreen();
      break;
    case 'AllPostsScreen':
      return AllPostsScreen();
      break;
    case 'EditPostScreen':
      return EditPostScreen();
      break;
    case 'ArtistProfileServices':
      return ArtistProfileServices();
      break;
    case 'EditServiceScreen':
      return EditServiceScreen();
      break;
    case 'SinglePostScreen':
      return SinglePostScreen(
        previousRoute: 'ArtistUserProfileScreen',
      );
      break;
    case 'ShopView':
      return ShopView();
      break;

    default:
      return ArtistUserProfileScreen();
      break;
  }
}
