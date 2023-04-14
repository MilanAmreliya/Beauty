import 'dart:ui';

import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/share_method.dart';
import 'package:beuty_app/dialogs/comment_dialog.dart';
import 'package:beuty_app/model/apiModel/requestModel/likepost_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

CommentAndLikePostViewModel likePostViewModel = Get.find();

Future<void> postPreviewDialog(
    {bool isOnTap = false,
    String title,
    String subTitle,
    String profileImg,
    List<String> listImg,
    String postId,
    bool isLike,
    bool isFavorite,
    String detail}) {
  int _currentPosition = 0;
  bool isLoading = false;

  PageController pageViewController = PageController();

  bool _isSelected = isFavorite;
  bool _isLike = isLike;

  return Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: StatefulBuilder(
      builder: (context, dialogSetState) {
        return SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              topProfileView(
                  title: title, subTitle: subTitle, profileImg: profileImg),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: Get.height * 0.65,
                      width: Get.width,
                      color: Colors.grey.withOpacity(0.3),
                      child: PageView(
                        controller: pageViewController,
                        children: List.generate(listImg.length, (index) {
                          /*return Image(
                                  image: NetworkImage('${homeDatum.services[index].image}'),
                                );*/
                          return listImg[index] == null || listImg[index] == ''
                              ? imageNotLoadRectangle()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: commonOctoImage(
                                    image: listImg[index],
                                    circleShape: false,
                                  ));
                        }),
                        onPageChanged: (int index) {
                          dialogSetState(() {
                            _currentPosition = index;
                          });
                        },
                      )),
                  SizedBox(
                    height: Get.height * 0.005,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.03,
                    ),
                    child: Row(
                      children: [
                        // Spacer(),
                        SizedBox(
                          width: Get.width / 2.5,
                        ),
                        listImg.length == 1
                            ? SizedBox()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:
                                    List.generate(listImg.length, (index) {
                                  return Padding(
                                    padding: EdgeInsets.all(Get.width * 0.005),
                                    child: CircleAvatar(
                                      radius: Get.height * 0.005,
                                      backgroundColor: index == _currentPosition
                                          ? Color(0xff424BE1)
                                          : Colors.grey,
                                    ),
                                  );
                                }),
                              ),
                        /*    Spacer(),
                        InkWell(
                          onTap: () async {
                            dialogSetState(() {
                              _isSelected = !_isSelected;
                            });
                            IsFavoriteReq model = IsFavoriteReq();
                            model.postId = postId;
                            model.isFav = _isSelected ? '1' : '0';
                            await likePostViewModel.isFavorite(model);
                            await addFavorite(
                                id: postId,
                                title: title,
                                subTitle: subTitle,
                                image: listImg[0]);
                          },
                          child: !_isSelected
                              ? Icon(
                                  Icons.favorite_border,
                                  color: Color(0xff424BE1),
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                        )*/
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                ],
              ),
              /*  description(detail),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      dialogSetState(() {
                        _isLike = !_isLike;
                      });
                      IsLikedPostReq isLike = IsLikedPostReq();
                      isLike.postId = postId;
                      isLike.isLiked = "0";
                      await likePostViewModel.isLike(isLike);
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
                      commentDialog(title: 'Add', postId: postId);
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset("assets/svg/comment.svg"),
                        // Image.asset('assets/image/chat.png'),
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
              ),
              isOnTap
                  ? isLoading
                      ? circularIndicator()
                      : Column(
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
                                      ArtistProfileViewModel viewModel =
                                          Get.find();
                                      dialogSetState(() {
                                        isLoading = true;
                                      });
                                      await viewModel.deleteArtistPost(postId);
                                      if (viewModel
                                              .deletePostApiResponse.status ==
                                          Status.COMPLETE) {
                                        PostSuccessResponse response = viewModel
                                            .deletePostApiResponse.data;
                                        if (response.message ==
                                            "post deleted successfully") {
                                          CommanWidget.snackBar(
                                              message: response.message);
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            Get.back();
                                            Get.back();
                                          });
                                        } else {
                                          CommanWidget.snackBar(
                                              message:
                                                  'Post not delete plz try again');
                                        }
                                      } else {
                                        CommanWidget.snackBar(
                                            message: "Server Error");
                                      }
                                      dialogSetState(() {
                                        isLoading = false;
                                      });
                                    }),
                                SizedBox(
                                  width: Get.height * 0.05,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    BottomBarViewModel _barController =
                                        Get.find();
                                    _barController
                                        .setSelectedRoute('EditPostScreen');
                                    _barController.setNewStoryPreviousRoute(
                                        'AllPostsScreen');
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
                                    child: Center(
                                        child: SvgPicture.asset(
                                            'assets/svg/edit.svg')),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                          ],
                        )
                  : SizedBox(),
            ],
          ),
        );
      },
    ),
  ));
}

Padding description(String des) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: 10),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        des,
        style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            height: Get.height * 0.0012),
      ),
    ),
  );
}

Padding topProfileView({String title, String subTitle, String profileImg}) {
  print('image:$profileImg');
  return Padding(
    padding:
        EdgeInsets.only(right: Get.width * 0.03, bottom: 10, top: 10, left: 10),
    child: Row(
      children: [
        PreferenceManager.getCustomerPImg() == null ||
                PreferenceManager.getCustomerPImg() == ''
            ? imageNotFound()
            : ClipOval(
                child: commonProfileOctoImage(
                  image: PreferenceManager.getCustomerPImg(),
                  height: Get.height * 0.06,
                  width: Get.height * 0.06,
                ),
              ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Get.height * 0.02,
                  fontFamily: "Poppins"),
            ),
            Text(
              subTitle ?? '',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: Get.height * 0.016,
                  fontFamily: "Poppins"),
            ),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: () async {
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff424BE1), width: 1)),
            child: Icon(
              Icons.clear,
              color: Color(0xff424BE1),
            ),
          ),
        ),
      ],
    ),
  );
}
