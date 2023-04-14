import 'dart:developer';

import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/images.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/show_ratting_bar.dart';
import 'package:beuty_app/dialogs/postViewDialog.dart';
import 'package:beuty_app/dialogs/serviceItemDialog.dart';
import 'package:beuty_app/dialogs/shopItemDialog.dart';
import 'package:beuty_app/model/apiModel/requestModel/single_post_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/check_isliked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/find_shop_by_filter_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/home_artist_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/home_screen_feed_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/text_style.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beuty_app/comman/favorite.dart';

class FilterShopDataScreen extends StatelessWidget {
  final String role;

   FilterShopDataScreen({Key key, this.role = 'Artist'}) : super(key: key);

  BottomBarViewModel _barController = Get.find();
  int count = 0, countPost = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('HomeScreen');
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: customAppBar(
          'Filter Shop',
          leadingOnTap: () {
            _barController.setSelectedRoute('HomeScreen');
          },
        ),
        body: GetBuilder<HomeTabViewModel>(
          builder: (controller) {
            int promotedCount = 0, postCount = 0;
            bool oneTimeMinus = false;
            if (controller.findShopByFilterApiResponse.status ==
                Status.LOADING) {
              return Center(child: circularIndicator());
            }
            if (controller.findShopByFilterApiResponse.status == Status.ERROR) {
              return Center(child: Text("Server Error"));
            }
            HomeScreenFeedResponse response =
                controller.findShopByFilterApiResponse.data;
            if (response.data.posts.isEmpty) {
              return Center(
                  child: Text(
                "No Shop Found...",
                style: TextStyle(color: Colors.white),
              ));
            }

            return  SingleChildScrollView(
              child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,

                    physics: NeverScrollableScrollPhysics(),
                    itemCount: response.data.posts.length + response.data.promotedShop.length,
                    //+ model.data.promotedShop.length ,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (response.data.promotedShop.length == 0) {
                        return homeFeedPost(response, index, role);
                      }

                      // model.data.promotedShop.length
                      if (index.isOdd && promotedCount < response.data.promotedShop.length) {
                        promotedCount++;
                        index = index - promotedCount;
                        return homeFeedPromoted(response, index, role);
                      }

                      index = index - postCount;
                      if (postCount == response.data.promotedShop.length && !oneTimeMinus) {
                        oneTimeMinus = true;
                      }
                      if (!oneTimeMinus) {
                        postCount++;
                      }

                      log("INDEX $index $postCount");

                      return homeFeedPost(response, index, role);
                    },
                  )
              ),
            );
          },
        ),
      ),
    );
  }
  Container homeFeedPromoted(
      HomeScreenFeedResponse model, int index, String role) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              model.data.promotedShop[index].artist.profilePic == null ||
                  model.data.promotedShop[index].artist.profilePic == ''
                  ? imageNotFound()
                  : ClipOval(
                child: commonOctoImage(
                  image: model.data.promotedShop[index].artist.profilePic,
                  height: Get.height * 0.06,
                  width: Get.height * 0.06,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    BottomBarViewModel _barController = Get.find();
                    _barController.setSelectedArtistId(
                        model.data.promotedShop[index].artistId);
                    print(_barController.selectedArtistId);
                    _barController.setSelectedRoute(
                        role== 'Artist'
                            ? 'FilterProfilePostScreen'
                            : "FilterModelProfilePostScreen");
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${model.data.promotedShop[index].artist.username ?? ''}",
                        overflow: TextOverflow.ellipsis,
                        style: postTitleStyle(),
                      ),
                      Text(
                        model.data.promotedShop[index].name ?? '',
                        style: postSubtitleStyle(),
                      )
                    ],
                  ),
                ),
              ),
              // Spacer(),
              // showRattingBar(
              //     model.data[index].shopRating?.toDouble() ?? 0.0),
              SizedBox(width: 10,),
              Row(
                children: [
                  Text(
                    'Promoted Shop',
                    style:
                    TextStyle(color: cRoyalBlue, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(height: 30, width: 30, child: iPromotedShop),
                ],
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              shopItemDialog(
                  userImg: model.data.promotedShop[index].artist.profilePic,
                  userName: model.data.promotedShop[index].artist.username,
                  userRole: model.data.promotedShop[index].artist.customerRole,
                  shopImg: model.data.promotedShop[index].img,
                  description: model.data.promotedShop[index].aboutShop);
            },
            child: SizedBox(
              height: Get.height * 0.3,
              child: model.data.promotedShop[index].img.isEmpty
                  ? imageNotFound()
                  : Padding(
                padding: EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: commonOctoImage(
                      image: model.data.promotedShop[index].img,
                      height: Get.height * 0.1,
                      width: Get.width,
                      circleShape: false,
                      fit: true),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(Icons.location_on_sharp),
              SizedBox(
                width: 10,
              ),
              Text("${model.data.promotedShop[index].address ?? ''}"),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          ExpandableText(
            "${model.data.promotedShop[index].aboutShop ?? ''}",
            expandText: 'show more',
            collapseText: 'show less',
            maxLines: 3,
            linkColor: Colors.blue,
            prefixText: "About Shop: - ",
            prefixStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            // expanded: false,
          ),
        ],
      ),
    );
  }

  Container homeFeedPost(HomeScreenFeedResponse model, int index, String role) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              model.data.posts[index].user.profilePic == null ||
                  model.data.posts[index].user.profilePic == ''
                  ? imageNotFound()
                  : ClipOval(
                child: commonOctoImage(
                  image: model.data.posts[index].user.profilePic,
                  height: Get.height * 0.06,
                  width: Get.height * 0.06,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  BottomBarViewModel _barController = Get.find();
                  _barController
                      .setSelectedArtistId(model.data.posts[index].user.id);
                  print(_barController.selectedArtistId);
                  _barController.setSelectedRoute(role == 'Artist'
                      ? 'FilterProfilePostScreen'
                      : "FilterModelProfilePostScreen");
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${model.data.posts[index].user.username ?? ''}",
                      style: postTitleStyle(),
                    ),
                    Text(
                      model.data.posts[index].user.customerRole ?? '',
                      style: postSubtitleStyle(),
                    )
                  ],
                ),
              ),
              // Spacer(),
              // showRattingBar(
              //     model.data[index].shopRating?.toDouble() ?? 0.0),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: Get.height * 0.3,
            child: PageView(
              children: List.generate(
                  model.data.posts[index].feedImage.length,
                      (serviceIndex) => InkWell(
                    onTap: () {
                      onTap(model, index);
                    },
                    child: model.data.posts[index].feedImage.isEmpty
                        ? imageNotFound()
                        : Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: commonOctoImage(
                            image: model.data.posts[index]
                                .feedImage[serviceIndex].path,
                            height: Get.height * 0.1,
                            width: Get.height * 0.1,
                            circleShape: false,
                            fit: true),
                      ),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),

        ],
      ),
    );
  }

  Future<void> onTap(HomeScreenFeedResponse model, int index) async {
    ///check like or not
    CommentAndLikePostViewModel likeViewModel = Get.find();
    await likeViewModel.getCheckPostLiked(
      model.data.posts[index].id.toString(),
    );

    bool likeStatus = false;
    if (likeViewModel.checkIsLikedApiResponse.status == Status.COMPLETE) {
      CheckIsLikedResponse likeRes = likeViewModel.checkIsLikedApiResponse.data;
      likeStatus = likeRes.data.liked;
    }
    print('like status:$likeStatus');

    ///set data in single post

    List<String> list = [];
    List<String> listDeviceToken = [];
    model.data.posts[index].feedImage.forEach((element) {
      list.add(element.path);
    });
    model.data.posts[index].user.deviceTokens.forEach((element) {
      listDeviceToken.add(element.deviceToken);
    });
    SinglePostRequestModel requestModel = SinglePostRequestModel();
    requestModel.artistId = model.data.posts[index].user.id.toString();
    requestModel.postImg = list;
    requestModel.postId = model.data.posts[index].id.toString();
    requestModel.isLike = likeStatus;
    requestModel.address = model.data.posts[index].user.shop.address;
    requestModel.deviceTokens = listDeviceToken;
    BottomBarViewModel _bottomBarViewModel = Get.find();
    _bottomBarViewModel.setSelectedRoute('SinglePostScreen');

    /*      CommentAndLikePostViewModel likeViewModel =
                                      Get.find();
                                  List<String> list = [];
                                  model.data.posts[index].feedImage
                                      .forEach((element) {
                                    list.add(element.path);
                                  });
                                  await likeViewModel.getCheckPostLiked(
                                    model.data.posts[index].id.toString(),
                                  );

                                  bool likeStatus = false;
                                  bool favoriteStatus = false;
                                  if (likeViewModel
                                          .checkIsLikedApiResponse.status ==
                                      Status.COMPLETE) {
                                    CheckIsLikedResponse likeRes = likeViewModel
                                        .checkIsLikedApiResponse.data;
                                    likeStatus = likeRes.data.liked;
                                  }
                                  favoriteStatus = checkFavorite(
                                      model.data.posts[index].id.toString());
                                  print('fav=>$favoriteStatus');
                                  postPreviewDialog(
                                      isLike: likeStatus,
                                      isFavorite: favoriteStatus,
                                      detail: model.data.posts[index].comments.isEmpty
                                          ? ''
                                          : model
                                              .data.posts[index].comments[0].comment,
                                      postId: model.data.posts[index].id.toString(),
                                      profileImg:
                                          model.data.posts[index].user.profilePic,
                                      title:
                                          model.data.posts[index].user.username ?? '',
                                      subTitle:
                                          model.data.posts[index].user.customerRole ??
                                              '',
                                      listImg: list);*/
  }

}

/*

GestureDetector(
onTap: () {
BottomBarViewModel _barController =
Get.find();
HomeTabViewModel controller =
Get.find();
_barController.setSelectedArtistId(
response.data[index].artist.id);
print("role:::>${controller.role}");

_barController.setSelectedRoute(
controller.role.value == 'Artist'
? 'FilterProfilePostScreen'
    : "FilterModelProfilePostScreen");
},
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Text(
response.data[index].name ?? "",
style: postTitleStyle(),
),
Text(
'${response.data[index].artist?.customerRole ?? ""}',
style: postSubtitleStyle(),
)
],
),
),*/
