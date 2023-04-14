import 'dart:developer';

import 'package:beuty_app/comman/box_decoration.dart';
import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/share_method.dart';
import 'package:beuty_app/comman/small_profile_header.dart';
import 'package:beuty_app/dialogs/comment_dialog.dart';
import 'package:beuty_app/model/apiModel/requestModel/likepost_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/single_post_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/services/app_notification.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SinglePostScreen extends StatefulWidget {
  final String previousRoute;

  SinglePostScreen({Key key, this.previousRoute}) : super(key: key);

  @override
  _SinglePostScreenState createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  SinglePostRequestModel _model = SinglePostRequestModel();
  RxBool isLike = false.obs;
  String storyId;
  BottomBarViewModel _barController = Get.find();
  TextEditingController editingController = TextEditingController();
  RxInt selectedSlideIndex = 0.obs;
  ArtistProfileViewModel artistProfileViewModel = Get.find();
  HomeTabViewModel homeTabViewModel = Get.find();
  bool _isLike = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('artist id : ${_model.artistId}');
    print('Like status : ${_model.isLike}');
    artistProfileViewModel.getProfileDetail(artistId: _model.artistId);
    _isLike = _model.isLike;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute(widget.previousRoute);
        artistProfileViewModel.clearGetPostData();

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cDarkBlue,
        appBar: customAppBar('Post', leadingOnTap: () {
          _barController.setSelectedRoute(widget.previousRoute);
          artistProfileViewModel.clearGetPostData();
        }),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
            decoration: bottomRadiusDecoration(),
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  header(),
                  postImage(),
                  dottedIndecator(),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on_outlined),
                        Expanded(
                            child: Text(
                          _model.address ?? 'N/A',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  likeShare(context),
                  _model.artistId ==
                          PreferenceManager.getArtistId().toString()
                      ? deletePostBtn()
                      : SizedBox()
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Column deletePostBtn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: Get.height * 0.01,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customBtn(
                    title: 'Delete',
                    height: Get.height * 0.050,
                    width: Get.width * 0.35,
                    radius: Get.width * 0.09,
                    onTap: () async {
                      ArtistProfileViewModel viewModel = Get.find();

                      await viewModel.deleteArtistPost(artistProfileViewModel
                          .getPostDataAdd[0].id
                          .toString());
                      if (viewModel.deletePostApiResponse.status ==
                          Status.COMPLETE) {
                        PostSuccessResponse response =
                            viewModel.deletePostApiResponse.data;
                        if (response.message == "post deleted successfully") {
                          CommanWidget.snackBar(message: response.message);
                          Future.delayed(Duration(seconds: 1), () {
                            _barController
                                .setSelectedRoute('ArtistUserProfileScreen');
                            artistProfileViewModel.clearGetPostData();
                          });
                        } else {
                          CommanWidget.snackBar(
                              message: 'Post not delete plz try again');
                        }
                      } else {
                        CommanWidget.snackBar(message: "Server Error");
                      }
                    }),
                SizedBox(
                  width: Get.height * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    EditPostRequestModel editPostRequestModel =
                        EditPostRequestModel();
                    editPostRequestModel.postId = _model.postId;
                    editPostRequestModel.statusText = _model.statusText;
                    editPostRequestModel.postImg = _model.postImg;
                    BottomBarViewModel _barController = Get.find();
                    _barController.setSelectedRoute('EditPostScreen');
                  },
                  child: Container(
                    height: Get.height * 0.050,
                    width: Get.height * 0.05,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cRoyalBlue1,
                        gradient: LinearGradient(colors: [
                          cRoyalBlue1,
                          cPurple,
                        ])),
                    child: Center(child: SvgPicture.asset('assets/svg/edit.svg')),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
          ],
        )
      ],
    );
  }

  Widget postImage() {
    return Container(
      height: Get.height * 0.45,
      child: PageView(
        onPageChanged: (value) {
          selectedSlideIndex.value = value;
        },
        children: _model.postImg
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                      color: Colors.grey.withOpacity(0.3),
                      child: e == null || e == ''
                          ? imageNotFound()
                          : commonOctoImage(
                              image: e, circleShape: false, fit: true)),
                ))
            .toList(),
      ),
    );
  }

  Widget dottedIndecator() {
    return _model.postImg.length < 2
        ? SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Obx(() => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_model.postImg.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(Get.width * 0.005),
                      child: CircleAvatar(
                        radius: Get.height * 0.005,
                        backgroundColor: index == selectedSlideIndex.value
                            ? Color(0xff424BE1)
                            : Colors.grey,
                      ),
                    );
                  }),
                )),
          );
  }

  Row likeShare(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () async {
            CommentAndLikePostViewModel likePostViewModel = Get.find();

            setState(() {
              _isLike = !_isLike;
            });

            IsLikedPostReq isLike = IsLikedPostReq();
            isLike.postId = _model.postId;
            isLike.isLiked = "0";
            await likePostViewModel.isLike(isLike);
            if (likePostViewModel.isLikeApiResponse.status == Status.COMPLETE) {
              PostSuccessResponse response =
                  likePostViewModel.isLikeApiResponse.data;
              if (response.message != 'unliked post') {
                log("IS LIKE");

                /* _model.deviceTokens.forEach((elemen  t) {
                    listDeviceToken.add(element.deviceToken);
                  });*/
                AppNotificationHandler.sendMessage(_model.deviceTokens);
                // AppNotificationHandler.sendMessage(PreferenceManager.getFCMToken());
              }
            }
          },
          child: Column(
            children: [
              _isLike
                  ? Icon(
                      Icons.star,
                      color: Colors.red,
                    )
                  : Icon(Icons.star_border),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Text(
                'Like',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Get.height * 0.014,
                    fontFamily: "Poppins"),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            commentDialog(
                title: 'Submit',
                postId: _model.postId,
                fcmTokenList: _model.deviceTokens);
          },
          child: Column(
            children: [
              SvgPicture.asset('assets/svg/comment.svg'),
              // Image.asset('assets/svg/chat.png'),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Text(
                'Comment',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Get.height * 0.014,
                    fontFamily: "Poppins"),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            share(context);
          },
          child: Column(
            children: [
              SvgPicture.asset('assets/svg/share.svg'),
              // Image.asset('assets/image/share.png'),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Text(
                'Share',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Get.height * 0.014,
                    fontFamily: "Poppins"),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget header() {
    return GetBuilder<ArtistProfileViewModel>(
      builder: (controller) {
        if (controller.artistProfileApiResponse.status == Status.LOADING) {
          return Center(child: circularIndicator());
        }
        if (controller.artistProfileApiResponse.status == Status.ERROR) {
          return SizedBox();
        }

        ArtistProfileDetailResponse response =
            controller.artistProfileApiResponse.data;
        print('name:${response.data.username}');
        return smallProfileHeader(
            imageUrl: response.data.image,
            name: response.data.username,
            subName: response.data.role,
            color: Colors.black,
            showPopup: false,
            offset: -5);
      },
    );
  }
}
