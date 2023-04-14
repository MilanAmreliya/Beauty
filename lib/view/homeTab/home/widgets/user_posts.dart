import 'dart:developer';
import 'dart:ui';

///// user_post
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/images.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/dialogs/shopItemDialog.dart';
import 'package:beuty_app/model/apiModel/requestModel/single_post_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/check_isliked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/home_screen_feed_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/text_style.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

int count = 0, countPost = 0;

Widget posts(String role) {
  return GetBuilder<HomeTabViewModel>(
    builder: (controller) {
      int promotedCount = 0, postCount = 0;
      bool oneTimeMinus = false;

      if (controller.getHomeFeedApiResponse.status == Status.COMPLETE) {
        print(controller.getHomeFeedApiResponse.status);
        HomeScreenFeedResponse model = controller.getHomeFeedApiResponse.data;
        if (model.data.posts.isEmpty) {
          return Text(
            "No data found",
            style: TextStyle(color: Colors.white),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemCount: model.data.posts.length + model.data.promotedShop.length,
          //+ model.data.promotedShop.length ,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (model.data.promotedShop.length == 0) {
              return homeFeedPost(model, index, role);
            }

            // model.data.promotedShop.length
            if (index.isOdd && promotedCount < model.data.promotedShop.length) {
              promotedCount++;
              index = index - promotedCount;
              return homeFeedPromoted(model, index, role);
            }

            index = index - postCount;
            if (postCount == model.data.promotedShop.length && !oneTimeMinus) {
              oneTimeMinus = true;
            }
            if (!oneTimeMinus) {
              postCount++;
            }

            log("INDEX $index $postCount");

            return homeFeedPost(model, index, role);
          },
        );
      }
      if (controller.getHomeFeedApiResponse.status == Status.ERROR) {
        return Center(
          child: Text('Server Error'),
        );
      }
      return Center(
        child: circularIndicator(),
      );
    },
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
                  _barController.setSelectedRoute(role == 'Artist'
                      ? 'ProfilePostScreen'
                      : "ModelProfilePostScreen");
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
                    ? 'ProfilePostScreen'
                    : "ModelProfilePostScreen");
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
        ExpandableText(
          "${model.data.posts[index].statusText ?? ''}",
          expandText: 'show more',
          prefixStyle: postTitleStyle(),
          prefixText: "@${model.data.posts[index].user.username ?? ''}",
          collapseText: 'show less',
          maxLines: 3,
          linkColor: Colors.blue,
          // expanded: false,
        ),
        model.data.posts[index].comments.isEmpty
            ? SizedBox()
            : Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Comments',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
        Text(
          "${model.data.posts[index].comments.isEmpty ? '' : model.data.posts[index].comments[0].comment}",
        ),
        model.data.posts[index].comments.length > 1
            ? TextButton(
                onPressed: () {
                  BottomBarViewModel _barController = Get.find();

                  HomeTabViewModel homeView = Get.find();
                  _barController.setSelectedRoute('ViewAllComments');
                  homeView.setSelectedComment(model.data.posts[index].comments);
                },
                child: Text('View All'))
            : SizedBox(),
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

}
