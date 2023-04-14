import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/small_profile_header.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/following_followers_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/commanScreen/chats/chat_screen.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/model_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FollowingScreen extends StatefulWidget {
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  BottomBarViewModel _barController = Get.find();

  ModelProfileViewModel _modelProfileViewModel = Get.find();

  @override
  void initState() {
    super.initState();
    _modelProfileViewModel
        .getFollowingFollowers(PreferenceManager.getArtistId().toString());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('ModalAppointmentScreen');

        return Future.value(false);
      },
      child: Scaffold(
        appBar: customAppBar(
          'Following',
          leadingOnTap: () {
            _barController.setSelectedRoute('ModalAppointmentScreen');
          },
          action: svgChat(),
        ),
        backgroundColor: cDarkBlue,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 5,
              ),
              GetBuilder<ArtistProfileViewModel>(
                builder: (controller) {
                  if (controller.artistProfileApiResponse.status ==
                      Status.COMPLETE) {
                    ArtistProfileDetailResponse response =
                        controller.artistProfileApiResponse.data;
                    return smallProfileHeader(
                        name: response.data.username ?? '',
                        subName: response.data.role ?? "",
                        imageUrl: response.data.image);
                  }
                  if (controller.artistProfileApiResponse.status ==
                      Status.ERROR) {
                    return Center(
                      child: Text('Server Error'),
                    );
                  }
                  return loadingIndicator();
                },
              ),
              SizedBox(
                height: 15,
              ),
              centerBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget centerBody({String title}) {
    return Expanded(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(35),
              )),
          child: GetBuilder<ModelProfileViewModel>(
            builder: (controller) {
              if (controller.followingFollowersApiResponse.status ==
                  Status.LOADING) {
                return Center(
                  child: circularIndicator(),
                );
              }
              if (controller.followingFollowersApiResponse.status ==
                  Status.ERROR) {
                return Center(
                  child: Text("Server Error"),
                );
              }
              FollowingFollowersResponse response =
                  controller.followingFollowersApiResponse.data;

              // ignore: missing_required_param
              return GetBuilder<BottomBarViewModel>(
                builder: (controller) {
                  return PreferenceManager.getCustomerRole() == 'Artist'
                      ? followData('Followers', response.followers)
                      : followData('Following', response.followings);
                },
              );
            },
          )),
    );
  }

  Column followData(String title, List<Follow> followData) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: followData.isEmpty
              ? Center(
                  child: Text('Data not found'),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      followData.length,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.height * 0.023),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.005,
                            ),
                            Container(
                              height: Get.height * 0.09,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(color: Colors.grey, blurRadius: 5)
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: Get.height * 0.02,
                                    top: Get.height * 0.01,
                                    bottom: Get.height * 0.01),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: followData[index].image == null ||
                                              followData[index].image == ''
                                          ? imageNotFound()
                                          : ClipOval(
                                              child: commonProfileOctoImage(
                                                image: followData[index].image,
                                                height: Get.height * 0.07,
                                                width: Get.height * 0.07,
                                              ),
                                            ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            followData[index].username ?? '',
                                            style: TextStyle(
                                                fontSize: Get.height * 0.018,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Poppins"),
                                          ),
                                          Text(
                                            followData[index].role ?? '',
                                            style: TextStyle(
                                                fontSize: Get.height * 0.014,
                                                fontFamily: "Poppins"),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: Get.height * 0.03,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text(
                                          "Following",
                                          style: TextStyle(
                                              fontSize: Get.height * 0.016,
                                              fontWeight: FontWeight.w800),
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.03,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Get.to(ChatScreen(
                                            userImg: followData[index].image,
                                            userName:
                                                followData[index].username ??
                                                    '',
                                            receiverId:
                                                followData[index].id.toString(),
                                          ));
                                        },
                                        child: SvgPicture.asset(
                                            "assets/svg/chat.svg"))
                                    // Align(
                                    //   alignment: Alignment.center,
                                    //   child: SvgPicture.asset(
                                    //     "assets/image/menu.svg",
                                    //     height: Get.height * 0.02,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        )
      ],
    );
  }

  Text artistType() {
    return Text(
      '${PreferenceManager.getCustomerRole() ?? ''}',
      style: TextStyle(
          color: cLightGrey,
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400),
    );
  }

  Text profileName() {
    return Text(
      '${PreferenceManager.getUserName() ?? ''}',
      style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600),
    );
  }
}
