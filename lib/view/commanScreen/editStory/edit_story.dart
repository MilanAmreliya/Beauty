import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/next_btn_shape.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/filter_icons.dart';
import 'widgets/selected_img_big.dart';
import 'widgets/selected_img_small.dart';

class EditStory extends StatelessWidget {
  BottomBarViewModel _barController = Get.find();
  RxInt selectedSlideIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('NewStory');

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cDarkBlue,
        appBar: _buildAppbar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppbar() {
    return customAppBar('Edit', leadingOnTap: () {
      _barController.setSelectedRoute('NewStory');
    }, action: nextBtnShape(functionOnTap: () {
      _barController.setSelectedRoute('ShareStory');
    }));
  }

  SizedBox _buildBody() {
    return SizedBox(
      width: Get.width,
      child: Obx(() => Column(
            children: [
              selectedImageBig(
                  selectedSlideIndex: selectedSlideIndex.value,
                  onPageChanged: (value) {
                    selectedSlideIndex.value = value;
                  }),
              SizedBox(
                height: 20,
              ),
              selectedImageSmall(
                selectedSlideIndex.value,
              ),
              GetBuilder<NewStoryViewModel>(
                builder: (controller) {
                  return filterIcons(
                      controller.selectedImgFile[selectedSlideIndex.value],selectedSlideIndex.value,);
                },
              )
            ],
          )),
    );
  }
}
