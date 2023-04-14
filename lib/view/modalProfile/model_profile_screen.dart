import 'dart:math';

import 'package:beuty_app/comman/big_profile_header.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/model/apiModel/requestModel/single_post_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/check_isliked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/modal_like_feed.dart';
import 'package:beuty_app/model/apiModel/responseModel/shopbalance_responce_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/appointment_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:beuty_app/viewModel/model_profile_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ModalProfileScreen extends StatefulWidget {
  @override
  _ModalProfileScreenState createState() => _ModalProfileScreenState();
}

class _ModalProfileScreenState extends State<ModalProfileScreen> {
  BottomBarViewModel _barController = Get.find();
  AppointmentViewModel appointmentViewModel = Get.find();
  ArtistProfileViewModel artistProfileViewModel = Get.find();

  ModelProfileViewModel modelProfileViewModel =
      Get.put(ModelProfileViewModel());
  List<StaggeredTile> tiles = <StaggeredTile>[];

  @override
  void initState() {
    super.initState();
    artistProfileViewModel.getProfileDetail(
        artistId: PreferenceManager.getArtistId().toString());

    modelProfileViewModel.modelLikedFeed();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedIndex(0);
        _barController.setSelectedRoute('HomeScreen');

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: customAppBar(
          'Profile',
          leadingOnTap: () {
            _barController.setSelectedIndex(0);
            _barController.setSelectedRoute('HomeScreen');
          },
          action: svgChat(),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),

                GetBuilder<ArtistProfileViewModel>(
                  builder: (controller) {
                    if (controller.shopBalanceApiResponse.status ==
                        Status.COMPLETE) {
                      ShopBalanceResponse response =
                          controller.shopBalanceApiResponse.data;
                      return bigProfileHeader(
                        context,
                        route: 'ArtistUserProfileScreen',
                      );
                    }

                    return bigProfileHeader(
                      context,
                      route: 'ArtistUserProfileScreen',
                    );
                  },
                ),

                // GestureDetector(
                //     onTap: () {
                //       ratingDialog();
                //     },
                //     child: Text(
                //       "Rate",
                //       style: TextStyle(color: Colors.white),
                //     )),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(40))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          likedPostWidget(),
                        ],
                      )),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget likedPostWidget() {
    return Expanded(
      child: GetBuilder<ModelProfileViewModel>(
        builder: (controller) {
          if (controller.modalLikedFeedApiResponse.status == Status.LOADING) {
            return Center(child: circularIndicator());
          }
          if (controller.modalLikedFeedApiResponse.status == Status.ERROR) {
            return Center(
              child: Text('No Post Found'),
            );
          }
          ModelLikedFeedResponse response =
              controller.modalLikedFeedApiResponse.data;
          if (response.data.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                'Post not available',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            );
          }
          response.data.forEach((element) {
            tiles.add(Random().nextInt(2) == 1
                ? StaggeredTile.count(1, 1.5)
                : StaggeredTile.count(1, 1));
          });
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.height * 0.022),
            child: Container(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 3,
                mainAxisSpacing: Get.height * 0.02,
                crossAxisSpacing: Get.height * 0.02,

                itemCount: response.data.length,
                itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () async {
                    ///check like or not
                    CommentAndLikePostViewModel likeViewModel = Get.find();

                    await likeViewModel.getCheckPostLiked(
                      response.data[index].id.toString(),
                    );
                    _barController
                        .setSelectedArtistId(response.data[index].customerId);
                    print(_barController.selectedArtistId);

                    bool likeStatus = false;
                    if (likeViewModel.checkIsLikedApiResponse.status ==
                        Status.COMPLETE) {
                      CheckIsLikedResponse likeRes =
                          likeViewModel.checkIsLikedApiResponse.data;
                      likeStatus = likeRes.data.liked;
                    }

                    ///Single post screen
                    List<String> list = [];
                    response.data[index].feedImage.forEach((element) {
                      list.add(element.path);
                    });

                    SinglePostRequestModel requestModel =
                        SinglePostRequestModel();
                    requestModel.artistId =
                        response.data[index].customerId.toString();
                    requestModel.postImg = list;
                    requestModel.postId = response.data[index].id.toString();
                    requestModel.isLike = likeStatus;
                    requestModel.address =
                        response.data[index].user.shop.address;
                    BottomBarViewModel _bottomBarViewModel = Get.find();
                    _bottomBarViewModel.setSelectedRoute('SinglePostScreen');

                    /*      CommentAndLikePostViewModel likeViewModel = Get.find();

                    await likeViewModel.getCheckPostLiked(
                      response.data[index].id.toString(),
                    );
                    _barController
                        .setSelectedArtistId(response.data[index].customerId);
                    print(_barController.selectedArtistId);

                    bool likeStatus = false;
                    bool favoriteStatus = false;
                    if (likeViewModel.checkIsLikedApiResponse.status ==
                        Status.COMPLETE) {
                      CheckIsLikedResponse likeRes =
                          likeViewModel.checkIsLikedApiResponse.data;
                      likeStatus = likeRes.data.liked;
                    }
                    favoriteStatus =
                        checkFavorite(response.data[index].id.toString());
                    likeViewModel.setIsLiked(likeStatus);

                    postItemDialog(
                        response.data[index], likeStatus, favoriteStatus);*/
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.grey.withOpacity(0.3),
                      child: response.data[index].feedImage.isEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black26,
                              ),
                              child: Center(child: Text('Image not load')),
                            )
                          : response.data[index].feedImage[0].path == null
                              ? imageNotFound()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: commonOctoImage(
                                      image: response
                                          .data[index].feedImage[0].path,
                                      circleShape: false,
                                      fit: true),
                                ),
                    ),
                  ),
                  /*  child: new Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/image/img1.jpg",
                            ),
                            fit: BoxFit.cover)),
                  ),*/
                ),
                staggeredTileBuilder: (int index) {
                  return index >= tiles.length ? null : tiles[index];
                },
                // mainAxisSpacing: 3.0,
                // crossAxisSpacing: 3.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
