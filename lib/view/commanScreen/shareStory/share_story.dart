import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/comman/home_tab_process_indecator.dart';
import 'package:beuty_app/model/apiModel/requestModel/create_story_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareStory extends StatelessWidget {
  BottomBarViewModel _barController = Get.find();
  HomeTabViewModel _homeTabViewModel = Get.find();

  RxInt selectedSlideIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('EditStory');
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cDarkBlue,
        appBar: customAppBar('New Story', leadingOnTap: () {
          _barController.setSelectedRoute('EditStory');
        }),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  selectedImg(),
                  sliderDotted()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.05),
              child: customBtn(
                  title: 'SHARE',
                  onTap: () async {
                    NewStoryViewModel viewModel = Get.find();
                    CreateStoryReqModel model = CreateStoryReqModel();
                    model.storyUrl = viewModel.selectedImgFinal.value;
                    await _homeTabViewModel.createStory(model);
                    if (_homeTabViewModel.apiResponse.status ==
                        Status.COMPLETE) {
                      PostSuccessResponse res =
                          _homeTabViewModel.apiResponse.data;
                      if (res.success) {
                        _barController.setSelectedRoute('HomeScreen');
                        _barController.setSelectedIndex(0);
                      } else {
                        CommanWidget.snackBar(message: 'Server Error');
                      }
                    } else {
                      CommanWidget.snackBar(message: 'Server Error');
                    }
                  }),
            )
          ],
        ),
        homeTabProcessIndicator()
      ],
    );
  }

  Padding sliderDotted() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: GetBuilder<NewStoryViewModel>(
        builder: (controller) {
          return controller.selectedImg.value.length == 1
              ? SizedBox()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      controller.selectedImg.value.length,
                      (index) => Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Obx(
                            () => CircleAvatar(
                              radius: 2.5,
                              backgroundColor: selectedSlideIndex.value == index
                                  ? cRoyalBlue
                                  : cDarkGrey,
                            ),
                          ))),
                );
        },
      ),
    );
  }

  Expanded selectedImg() {
    return Expanded(
      child: GetBuilder<NewStoryViewModel>(
        builder: (controller) {
          return PageView(
              onPageChanged: (value) {
                selectedSlideIndex.value = value;
              },
              children: controller.selectedImgFinal.value
                  .map((e) => Image(
                        image: MemoryImage(e),
                        fit: BoxFit.cover,
                      ))
                  .toList());
        },
      ),
    );
  }
}
