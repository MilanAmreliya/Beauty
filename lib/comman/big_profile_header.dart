import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/popup.dart';
import 'package:beuty_app/comman/user_uper_data.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ArtistProfileViewModel profileViewModel = Get.find();
BottomBarViewModel _barController = Get.find();

Widget bigProfileHeader(BuildContext context, {String route, String balance}) {
  return GetBuilder<ArtistProfileViewModel>(
    builder: (controller) {
      if (controller.artistProfileApiResponse.status == Status.COMPLETE) {
        ArtistProfileDetailResponse response =
            controller.artistProfileApiResponse.data;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: popupBtnMenu(
                  profileImg: response.data.image,
                )),
            response.data.image == null || response.data.image == ''
                ? imageNotFound()
                : ClipOval(
                    child: commonProfileOctoImage(
                      image: response.data.image,
                      height: Get.height * 0.1,
                      width: Get.height * 0.1,
                    ),
                  ),
            SizedBox(
              height: 8,
            ),
            Text(
              response.data.username ?? "",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            Text(
              response.data.role ?? '',
              style: TextStyle(
                  color: cLightGrey,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 5,
            ),
            /* showRattingBar(response.data.review.toDouble()),*/
            SizedBox(
              height: 10,
            ),
            Row(
              children: balance == null
                  ? [
                      Spacer(),
                      InkWell(
                          onTap: () {
                            BottomBarViewModel _barController = Get.find();
                            _barController.setSelectedRoute('FollowingScreen');
                          },
                          child: userData(
                              "Following", '${response.data.followingCount}')),
                      Spacer(),
                    ]
                  : [
                      Spacer(),
                      Expanded(
                          flex: 2,
                          child: userData(
                              "Follower", '${response.data.followerCount}')),
                      Spacer(),
                      /* Expanded(
                          flex: 2,
                          child: userData(
                              "Following", '${response.data.followingCount}')),
                      Spacer(),*/
                      Expanded(
                          flex: 2,
                          child:
                              userData("Posts", '${response.data.postCount}')),
                      Spacer(),
                    ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(response.data.bio ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400)),
            SizedBox(
              height: 10,
            ),
            balance == null
                ? SizedBox()
                : GestureDetector(
                    onTap: () {
                      BottomBarViewModel _barController = Get.find();

                      _barController.setSelectedRoute('Balance');
                      _barController.setBalancePreviousRoute(route);
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: cRoyalBlue,
                          borderRadius: BorderRadius.circular(35),
                          gradient: LinearGradient(colors: [
                            cRoyalBlue1,
                            cPurple,
                          ])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                'Balance',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Center(
                            child: Text(
                              "\$$balance",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
            SizedBox(
              height: 8,
            ),
            balance == null
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      _barController.setSelectedRoute('ArtistProfileServices');
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: cRoyalBlue,
                          borderRadius: BorderRadius.circular(35),
                          gradient: LinearGradient(colors: [
                            cRoyalBlue1,
                            cPurple,
                          ])),
                      child: Center(
                        child: Text(
                          'Manage Shop',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
          ],
        );
      }
      if (controller.artistProfileApiResponse.status == Status.ERROR) {
        return Center(
          child: Text('Server Error'),
        );
      }
      return SizedBox(height: Get.height * 0.3, child: loadingIndicator());
    },
  );
}
