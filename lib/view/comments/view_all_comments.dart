import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beuty_app/model/apiModel/responseModel/home_screen_feed_response_model.dart';

class ViewAllComments extends StatelessWidget {
  BottomBarViewModel _barController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('HomeScreen');
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: customAppBar('Comments', leadingOnTap: () {
            _barController.setSelectedRoute('HomeScreen');
          }),
          body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return GetBuilder<HomeTabViewModel>(
      builder: (controller) {
        return ListView(
          padding: EdgeInsets.only(top: 20),
          children: controller.selectedComment.value
              .map((e) => Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        e.user?.profilePic == null || e.user.profilePic == ''
                            ? imageNotFound()
                            : Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    shape: BoxShape.circle),
                                child: ClipOval(
                                  child: commonProfileOctoImage(
                                    image: e.user.profilePic,
                                    height: Get.height * 0.07,
                                    width: Get.height * 0.07,
                                  ),
                                ),
                              ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.user?.username ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(e.comment ?? ''),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}
