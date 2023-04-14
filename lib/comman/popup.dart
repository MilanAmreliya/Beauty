import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/genralScreen/setting_screen.dart';
import 'package:beuty_app/view/profileTab/editProfile/edit_profile_screen.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'comman_widget.dart';

Widget popupBtnMenu({double offset, String profileImg,Color color=Colors.white}) {
  return PopupMenuButton(
    offset: Offset(0.0, offset ?? 15.0),
    onSelected: (value) {
      if (value == 2) {
        Get.to(SettingScreen());
      } else if (value == 1) {
        Get.to(EditProfileScreen(
          image: profileImg,
        ));
      }
    },
    itemBuilder: (context) => [
      // PopupMenuItem(
      //   child: Text("Change profile pic"),
      //   value: 1,
      // ),
      PopupMenuItem(
        child: Text("Edit profile"),
        value: 1,
      ),
      PopupMenuItem(
        child: Text("Settings"),
        value: 2,
      ),
    ],
    icon: Icon(
      Icons.more_vert,
      color:color,
    ),
  );
}

Widget deletePopupBtnMenu(String storyId) {
  return PopupMenuButton(
    offset: Offset(0.0, 0.0),
    onSelected: (value) async {
      if (value == 1) {
        ArtistProfileViewModel artistProfileViewModel = Get.find();
        await artistProfileViewModel.deleteStory(
            storyId, PreferenceManager.getArtistId().toString());
        if (artistProfileViewModel.deleteStoryApiResponse.status ==
            Status.COMPLETE) {
          PostSuccessResponse response =
              artistProfileViewModel.deleteStoryApiResponse.data;
          if (response.success) {
            CommanWidget.snackBar(
              message: response.message,
            );
            BottomBarViewModel _barController = Get.find();

            Future.delayed(Duration(seconds: 2), () {
              _barController.setSelectedRoute("HomeScreen");
            });
          } else {
            CommanWidget.snackBar(
              message: "Story not deleted",
            );
          }
        } else {
          CommanWidget.snackBar(
            message: "Server Error",
          );
        }
      }
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        child: Text("Delete"),
        value: 1,
      ),
    ],
    icon: Icon(
      Icons.more_vert,
      color: Colors.black,
    ),
  );
}
