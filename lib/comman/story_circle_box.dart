import 'package:beuty_app/model/apiModel/responseModel/get_artist_allstory_response_model.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common_octo_image.dart';

Widget storyBox(int id,
    {List<StoryImage> image, String artistId, String profileImg}) {
  BottomBarViewModel _barController = Get.find();

  return GestureDetector(
    onTap: () {
      NewStoryViewModel _newStoryViewModel = Get.find();
      _newStoryViewModel.getSingleStory(id, artistId);
      print('id=>$id');
      _barController.setSelectedRoute('ViewStory');
    },
    child: CircleAvatar(
      radius: Get.width * 0.075,
      backgroundColor: Colors.white,
      child: profileImg == null || profileImg == ''
          ? imageNotFound()
          : ClipOval(
              child: commonProfileOctoImage(
                image: profileImg,
                height: Get.height * 0.07,
                width: Get.height * 0.07,
              ),
            ),
      // backgroundImage:
      //     AssetImage('assets/image/story${index % 2 == 0 ? '2' : '3'}.png'),
    ),
  );
}
