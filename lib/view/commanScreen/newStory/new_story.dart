import 'package:beuty_app/comman/box_decoration.dart';
import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/next_btn_shape.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/bottom_header.dart';
import 'widgets/header_first.dart';
import 'widgets/selected_img.dart';

class NewStory extends StatelessWidget {
  BottomBarViewModel _barController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarViewModel>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            _barController
                .setSelectedRoute(controller.newStoryPreviousRoute.value);

            return Future.value(false);
          },
          child: Scaffold(
            backgroundColor: cDarkBlue,
            appBar: _buildAppbar(controller.newStoryPreviousRoute.value),
            body: _buildBody(),
          ),
        );
      },
    );
  }

  AppBar _buildAppbar(String route) {
    return customAppBar('New Story', leadingOnTap: () {
      _barController.setSelectedRoute(route);
    }, action: nextBtnShape(functionOnTap: () {
      NewStoryViewModel newStoryViewModel=Get.find();
      if(newStoryViewModel.selectedImg.value.isEmpty){
        CommanWidget.snackBar(message: 'Please select min one image');
        return;
      }
      _barController.setSelectedRoute('EditStory');
    }));
  }

  SizedBox _buildBody() {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          Expanded(
            child: Container(
                width: Get.width,
                decoration: bottomRadiusDecoration(),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    headerFirst(),
                    SizedBox(
                      height: 20,
                    ),
                    selectedImg()
                  ],
                )),
          ),
          bottomHeader(_barController),
        ],
      ),
    );
  }
}
