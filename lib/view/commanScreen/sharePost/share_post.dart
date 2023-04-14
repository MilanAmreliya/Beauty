import 'dart:typed_data';

import 'package:beuty_app/comman/box_decoration.dart';
import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/comman/home_tab_process_indecator.dart';
import 'package:beuty_app/model/apiModel/requestModel/create_post_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharePost extends StatelessWidget {
  BottomBarViewModel _barController = Get.find();
  HomeTabViewModel _homeTabViewModel = Get.find();
  RxInt selectedSlideIndex = 0.obs;
  TextEditingController messageController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('NewStory');
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cDarkBlue,
        appBar: customAppBar('Post', leadingOnTap: () {
          _barController.setSelectedRoute('NewStory');
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
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40)),
                child: Container(
                  height: Get.height * 0.5,
                  width: Get.width,
                  decoration: bottomRadiusDecoration(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        selectedImg(),
                        sliderDotted(),
                        commentTextField()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.05),
              child: customBtn(
                  title: 'SHARE',
                  onTap: () async {
                    NewStoryViewModel viewModel = Get.find();
                    CreatePostReqModel model = CreatePostReqModel();
                    if (formKey.currentState.validate()) {
                      model.customerId =
                          PreferenceManager.getArtistId().toString();
                      model.contentType = contentController.text;
                      model.feedUrl = viewModel.selectedImgFinal.value;
                      model.statusText = messageController.text;
                      await _homeTabViewModel.createPost(model);
                      if (_homeTabViewModel.apiResponse.status ==
                          Status.COMPLETE) {
                        PostSuccessResponse res =
                            _homeTabViewModel.apiResponse.data;
                        if (res.success) {
                          _barController.setSelectedRoute('HomeScreen');
                          _barController.setSelectedIndex(0);
                        } else {
                          CommanWidget.snackBar(message: 'Server Error : ');
                        }
                      } else {
                        CommanWidget.snackBar(message: 'Server Error');
                      }
                    }
                  }),
            )
          ],
        ),
        homeTabProcessIndicator()
      ],
    );
  }

  Widget commentTextField() {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: cLightGrey),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                maxLines: 4,
                validator: (value) {
                  if (value.isEmpty) {
                    return '* Required';
                  }
                  return null;
                },
                controller: messageController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write Status Text..',
                    hintStyle: TextStyle(color: cDarkGrey)),
              ),
            ),
           
          ],
        ));
  }

  Padding sliderDotted() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: GetBuilder<NewStoryViewModel>(
        builder: (controller) {
          return controller.selectedImg.value.length==1?SizedBox():Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
                controller.selectedImg.value.length,
                (index) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Obx(
                      () => CircleAvatar(
                        radius: 2.5,
                        backgroundColor: selectedSlideIndex.value == index
                            ? cPurple
                            : cDarkGrey,
                      ),
                    ))),
          );
        },
      ),
    );
  }

  SizedBox selectedImg() {
    return SizedBox(
        width: Get.width,
        child: GetBuilder<NewStoryViewModel>(
          builder: (controller) {
            return controller.selectedImg.value.length == 1
                ? imageShow(controller.selectedImg.value[0])
                : CarouselSlider(
                    options: CarouselOptions(
                      reverse: false,
                      height: Get.height * 0.3,
                      viewportFraction: 0.70,
                      onPageChanged: (index, reason) {
                        selectedSlideIndex.value = index;
                      },
                    ),
                    items: controller.selectedImg.value.map((i) {
                      return imageShow(i);
                    }).toList(),
                  );
          },
        ));
  }

  Container imageShow(Uint8List i) {
    return Container(
      width: Get.width,
      height: Get.height * 0.3,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: MemoryImage(i),
            fit: BoxFit.cover,
          )),
    );
  }
}
