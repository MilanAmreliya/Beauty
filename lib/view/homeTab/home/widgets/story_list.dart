import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/comman/story_circle_box.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_artist_allstory_response_model.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/const.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/apis/api_response.dart';

Padding storyList(
  String role,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    child: GetBuilder<NewStoryViewModel>(
      builder: (controller) {
        if (controller.apiResponse.status == Status.LOADING) {
          return Center(
            child: circularIndicator(),
          );
        }
        if (controller.apiResponse.status == Status.ERROR) {
          return SizedBox();
        }
        GetArtistAllStoryResponse response = controller.apiResponse.data;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Row(
            children: List.generate(
              response.data.length + (role == "Artist" ? 1 : 0),
              (index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: role == "Artist"
                      ? index == 0
                          ? addStoryBox()
                          : storyBox(response.data[index - 1].id,
                              image: response.data[index - 1].storyImage,
                              artistId:
                                  response.data[index - 1].artistId.toString(),
                              profileImg: response
                                          .data[index - 1].user.profilePic ==
                                      null
                                  ? null
                                  : response.data[index - 1].user.profilePic)
                      : storyBox(response.data[index].id,
                          image: response.data[index].storyImage,
                          artistId: response.data[index].artistId.toString(),
                          profileImg: response.data[index].user.profilePic)),
            ),
          ),
        );
      },
    ),
  );
}

Widget addStoryBox() {
  BottomBarViewModel _barController = Get.find();
  return GestureDetector(
    onTap: () {
      _barController.setSelectedRoute('NewStory');
      _barController.setNewStoryPreviousRoute('HomeScreen');
      NewStoryViewModel viewModel = Get.find();
      viewModel.clearSelectedImg();
    },
    child: CircleAvatar(
        radius: Get.width * 0.077,
        backgroundColor: Colors.white,
        child: Image.asset('assets/image/add.png')),
  );
}
