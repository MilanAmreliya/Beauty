import 'dart:math';

import 'package:beuty_app/comman/big_profile_header.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/model/apiModel/requestModel/single_post_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/check_isliked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_post_by_id_response.dart';
import 'package:beuty_app/model/apiModel/responseModel/shopbalance_responce_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ArtistUserProfileScreen extends StatefulWidget {
  const ArtistUserProfileScreen({Key key}) : super(key: key);

  @override
  _ArtistUserProfileScreenState createState() =>
      _ArtistUserProfileScreenState();
}

class _ArtistUserProfileScreenState extends State<ArtistUserProfileScreen> {
  BottomBarViewModel _barController = Get.find();
  ArtistProfileViewModel _profileViewModel = Get.find();
  List<StaggeredTile> tiles = <StaggeredTile>[];
  ArtistProfileViewModel artistProfileViewModel = Get.find();
  CommentAndLikePostViewModel likeViewModel = Get.find();

  @override
  void initState() {
    _profileViewModel.getProfileDetail();
    artistProfileViewModel.getPostByArtist();
    artistProfileViewModel
        .getShopByCreate(PreferenceManager.getArtistId().toString());
    artistProfileViewModel.checkShopAvailable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('HomeScreen');
        _barController.setSelectedIndex(0);

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
                    _barController.setSelectedRoute('HomeScreen');
                    _barController.setSelectedIndex(0);
                  },
                  action: svgChat(),
                );
              }
              ArtistProfileDetailResponse response =
                  controller.artistProfileApiResponse.data;
              return customAppBar(
                response.data.username ?? '',
                leadingOnTap: () {
                  _barController.setSelectedRoute('HomeScreen');
                  _barController.setSelectedIndex(0);
                },
                action: svgChat(),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                GetBuilder<ArtistProfileViewModel>(
                  builder: (controller) {
                    if (controller.shopBalanceApiResponse.status ==
                        Status.COMPLETE) {
                      ShopBalanceResponse response =
                          controller.shopBalanceApiResponse.data;
                      return bigProfileHeader(context,
                          route: 'ArtistUserProfileScreen',
                          balance: " ${response.data.balance ?? "0"}");
                    }

                    return bigProfileHeader(context,
                        route: 'ArtistUserProfileScreen', balance: "0");
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width / 2.3,
                            ),
                            Text(
                              "Post",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Get.height / 30,
                                  fontFamily: 'Poppins'),
                            ),
                            SizedBox(
                              width: Get.width / 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                NewStoryViewModel _storyViewModel = Get.find();
                                _storyViewModel.clearSelectedImg();
                                _barController.setSelectedRoute('NewStory');
                                _barController.setNewStoryPreviousRoute(
                                    'ArtistUserProfileScreen');
                              },
                              child: Container(
                                height: Get.height / 13,
                                width: Get.width / 6,
                                //color: Colors.deepOrange,
                                child: SvgPicture.asset(
                                  "assets/svg/round_button.svg",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Container(
                            width: Get.width,
                            //color: Colors.blueAccent,
                            child: GetBuilder<ArtistProfileViewModel>(
                              builder: (controller) {
                                if (controller
                                        .postByArtistIdApiResponse.status ==
                                    Status.LOADING) {
                                  return Center(child: circularIndicator());
                                }
                                if (controller
                                        .postByArtistIdApiResponse.status ==
                                    Status.ERROR) {
                                  return Center(child: Text("Server Error"));
                                }
                                GetPostByIdResponse response =
                                    controller.postByArtistIdApiResponse.data;
                                if (response.data.isEmpty) {
                                  return Center(
                                    child: Text('Post not available'),
                                  );
                                }
                                response.data.forEach((element) {
                                  tiles.add(Random().nextInt(2) == 1
                                      ? StaggeredTile.count(1, 1.5)
                                      : StaggeredTile.count(1, 1));
                                });
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.height * 0.022),
                                  child: Container(
                                    child: StaggeredGridView.countBuilder(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: Get.height * 0.02,
                                      crossAxisSpacing: Get.height * 0.02,

                                      itemCount: response.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              InkWell(
                                        onTap: () {
                                          onTapSinglePost(response, index);
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            color: Colors.grey.withOpacity(0.3),
                                            child: response.data[index]
                                                    .feedImage.isEmpty
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Colors.black26,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                            'Image not load')),
                                                  )
                                                : response
                                                            .data[index]
                                                            .feedImage[0]
                                                            .path ==
                                                        null
                                                    ? imageNotFound()
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: commonOctoImage(
                                                            image: response
                                                                .data[index]
                                                                .feedImage[0]
                                                                .path,
                                                            circleShape: false,
                                                            fit: true),
                                                      ),
                                          ),
                                        ),
                                      ),
                                      staggeredTileBuilder: (int index) {
                                        return index >= tiles.length
                                            ? null
                                            : tiles[index];
                                      },
                                      // mainAxisSpacing: 3.0,
                                      // crossAxisSpacing: 3.0,
                                    ),
                                  ),
                                );

                                /* ListView.builder(
                                  itemCount: response.data.length,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return MaterialButton(
                                      onPressed: () async {
                                        */ /*  print(
                                            "profile img:${PreferenceManager.getCustomerPImg()}");
                                        var postId = response.data[index].id;
                                        response.data.forEach((element) {
                                          if (element.id == postId) {
                                            artistProfileViewModel
                                                .setGetPostDataAdd(element);
                                          }
                                        });
                                        List<String> list = [];
                                        response.data[index].feedImage
                                            .forEach((element) {
                                          list.add(element.path);
                                        });
                                        await likeViewModel.getCheckPostLiked(
                                            response.data[index].id.toString());

                                        bool likeStatus = false;
                                        bool favoriteStatus = false;
                                        if (likeViewModel
                                            .checkIsLikedApiResponse.status ==
                                            Status.COMPLETE) {
                                          CheckIsLikedResponse likeRes =
                                              likeViewModel
                                                  .checkIsLikedApiResponse.data;
                                          likeStatus = likeRes.data.liked;
                                        }
                                        favoriteStatus = checkFavorite(
                                            response.data[index].id.toString());
                                        postPreviewDialog(
                                            isOnTap: true,
                                            isFavorite: favoriteStatus,
                                            title: response.data[index].statusText,
                                            subTitle:
                                            response.data[index].statusHeadline,
                                            detail: '',
                                            listImg: list,
                                            isLike: likeStatus,
                                            postId:
                                            response.data[index].id.toString(),
                                            profileImg: '');*/ /*
                                      },
                                      child: Container(
                                        height: Get.height / 8,
                                        width: Get.width,
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    Colors.grey.withOpacity(.3),
                                                spreadRadius: 2,
                                                blurRadius: 5)
                                          ],
                                        ),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: response.data[index]
                                                          .feedImage.isEmpty
                                                      ? imageNotFound()
                                                      : response
                                                                      .data[
                                                                          index]
                                                                      .feedImage[
                                                                          0]
                                                                      .path ==
                                                                  null ||
                                                              response
                                                                      .data[
                                                                          index]
                                                                      .feedImage[
                                                                          0]
                                                                      .path ==
                                                                  ''
                                                          ? imageNotFound()
                                                          : ClipOval(
                                                              child: commonOctoImage(
                                                                  height:
                                                                      Get.height *
                                                                          0.07,
                                                                  width:
                                                                      Get.height *
                                                                          0.07,
                                                                  image: response
                                                                      .data[
                                                                          index]
                                                                      .feedImage[
                                                                          0]
                                                                      .path),
                                                            )),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    response.data[index]
                                                            .statusText ??
                                                        '',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize:
                                                            Get.height / 45,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    response.data[index]
                                                            .statusHeadline ??
                                                        '',
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xffBBBDC1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: showRattingBar(),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "${DateFormat('dd.MM.yy').format(response.data[index].createdAt)}",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff080A0C)),
                                                  ),
                                                  Text(
                                                    "${DateFormat.jm().format(response.data[index].createdAt)}",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff080A0C)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        // color: Colors.blue,
                                      ),
                                    );
                                  },
                                );*/
                              },
                            ),
                          ),
                        ),
                      ],
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

  Future<void> onTapSinglePost(GetPostByIdResponse response, int index) async {
    ///check like or not
    CommentAndLikePostViewModel likeViewModel = Get.find();
    await likeViewModel.getCheckPostLiked(
      response.data[index].id.toString(),
    );

    bool likeStatus = false;
    if (likeViewModel.checkIsLikedApiResponse.status == Status.COMPLETE) {
      CheckIsLikedResponse likeRes = likeViewModel.checkIsLikedApiResponse.data;
      likeStatus = likeRes.data.liked;
    }
    print('like status:$likeStatus');

    artistProfileViewModel.setGetPostDataAdd(response.data[index]);

    ///set data in single post

    List<String> list = [];
    List<String> listDeviceToken = [];

    response.data[index].feedImage.forEach((element) {
      list.add(element.path);
    });
    response.deviceToken.forEach((element) {
      listDeviceToken.add(element.deviceToken);
    });
    SinglePostRequestModel requestModel = SinglePostRequestModel();
    requestModel.artistId = response.data[index].customerId.toString();
    requestModel.postImg = list;
    requestModel.statusText = response.data[index].statusText;
    requestModel.postId = response.data[index].id.toString();
    requestModel.isLike = likeStatus;
    requestModel.address = response.shop[0].address;
    requestModel.deviceTokens=listDeviceToken;
    BottomBarViewModel _bottomBarViewModel = Get.find();
    _bottomBarViewModel.setSelectedRoute('SinglePostScreen');
  }
}
