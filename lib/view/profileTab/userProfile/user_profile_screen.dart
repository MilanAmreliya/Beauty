import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/popup.dart';
import 'package:beuty_app/comman/show_ratting_bar.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/comman/user_uper_data.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  BottomBarViewModel _barController = Get.find();
  ArtistProfileViewModel _profileViewModel = Get.find();

  @override
  void initState() {
    _profileViewModel.getProfileDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('ArtistUserProfileScreen');

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cDarkBlue,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: GetBuilder<ArtistProfileViewModel>(
            builder: (controller) {
              if (controller.artistProfileApiResponse.status !=
                  Status.COMPLETE) {
                return customAppBar(
                  '',
                  leadingOnTap: () {
                    _barController.setSelectedRoute('ArtistUserProfileScreen');
                  },
                  action: svgChat(),
                );
              }
              ArtistProfileDetailResponse response =
                  controller.artistProfileApiResponse.data;
              return customAppBar(
                response.data.username ?? '',
                leadingOnTap: () {
                  _barController.setSelectedRoute('ArtistUserProfileScreen');
                },
                action: svgChat(),
              );
            },
          ),
        ),
        // customAppBar(
        //   'Robert Phan',
        //   leadingOnTap: () {
        //     _barController.setSelectedRoute('HomeScreen');
        //     _barController.setSelectedIndex(0);
        //   },
        //   action: svgChat(),
        // ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                GetBuilder<ArtistProfileViewModel>(
                  builder: (controller) {
                    if (controller.artistProfileApiResponse.status ==
                        Status.ERROR) {
                      return Center(
                        child: Text('Server Error'),
                      );
                    }
                    if (controller.artistProfileApiResponse.status ==
                        Status.COMPLETE) {
                      ArtistProfileDetailResponse model =
                          controller.artistProfileApiResponse.data;
                      return Column(
                        children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: popupBtnMenu()),
                          model.data.image == null || model.data.image == ''
                              ? imageNotFound()
                              : ClipOval(
                                  child: commonProfileOctoImage(
                                    image: model.data.image,
                                    height: Get.height * 0.1,
                                    width: Get.height * 0.1,
                                  ),
                                ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${model.data.username}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "${model.data.role ?? ''}",
                            style: TextStyle(
                                color: cLightGrey,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          showRattingBar(),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              /* Spacer(),
                              userData(
                                  "Follower", '${model.data.followerCount}'),
                              Spacer(),
                              userData(
                                  "Following", '${model.data.followingCount}'),*/
                              Spacer(),
                              userData("Posts", '${model.data.postCount}'),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400)),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      );
                    } else {
                      return loadingIndicator();
                    }
                  },
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CommanWidget.sizedBox6_5(),
                          InkWell(
                              onTap: () {
                                NewStoryViewModel _storyViewModel = Get.find();
                                _storyViewModel.clearSelectedImg();
                                _barController.setSelectedRoute('NewStory');
                                _barController.setNewStoryPreviousRoute(
                                    'UserProfileScreen');
                              },
                              child: CommanWidget.transparentButton(
                                  title: "Upload Post")),
                          CommanWidget.sizedBox25(),
                          InkWell(
                              onTap: () {
                                _barController
                                    .setSelectedRoute('CreateShopScreen');
                              },
                              child: CommanWidget.transparentButton(
                                  title: "Create shop")),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
