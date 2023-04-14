
import 'package:beuty_app/comman/box_decoration.dart';
import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/popup.dart';
import 'package:beuty_app/comman/share_method.dart';
import 'package:beuty_app/model/apiModel/requestModel/story_comment_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/story_like_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/single_story_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/text_style.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class ViewStory extends StatelessWidget {
  final String previousRoute;
  RxBool isLike = false.obs;
  String storyId;
  BottomBarViewModel _barController = Get.find();
  TextEditingController editingController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  RxInt selectedSlideIndex = 0.obs;

  ViewStory({Key key, this.previousRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute(previousRoute);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cDarkBlue,
        appBar: customAppBar('Story', leadingOnTap: () {
          _barController.setSelectedRoute(previousRoute);
        }),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GetBuilder<NewStoryViewModel>(
      builder: (controller) {
        if (controller.singleStoryApiResponse.status == Status.COMPLETE) {
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: bottomRadiusDecoration(),
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Column(
                        children: [
                          header(controller.singleStoryApiResponse.data),
                          postImage(controller.singleStoryApiResponse.data),
                          sliderDotted(controller.singleStoryApiResponse.data),
                          likeShare(
                              controller.singleStoryApiResponse.data, context)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                  // commentTextField((controller.singleStoryApiResponse.data
                  //         as SingleStoryResponse)
                  //     .data
                  //     .id),
                ],
              ),
              controller.storyCommentApiResponse.status == Status.LOADING
                  ? loadingIndicator()
                  : SizedBox()
            ],
          );
        }
        if (controller.singleStoryApiResponse.status == Status.LOADING) {
          return Center(child: Text("Server Error"));
        }
        return Center(child: circularIndicator());
      },
    );
  }

  Padding sliderDotted(SingleStoryResponse model) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: model.data.storyImages.length == 1
          ? SizedBox()
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  model.data.storyImages.length,
                  (index) => Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Obx(
                        () => CircleAvatar(
                          radius: 2.5,
                          backgroundColor: selectedSlideIndex.value == index
                              ? cRoyalBlue
                              : cDarkGrey,
                        ),
                      ))),
            ),
    );
  }

  Container commentTextField(int id) {
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(20, Get.height * 0.04, 20, Get.height * 0.05),
      width: Get.width,
      decoration: BoxDecoration(
          border: Border.all(
            color: cWhite,
          ),
          borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.only(left: 20),
      child: TextField(
        controller: editingController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: 'Say something..',
            hintStyle: TextStyle(color: cDarkGrey),
            border: InputBorder.none,
            suffixIcon: InkWell(
              onTap: () {
                onCommentTap(id);
              },
              child: Icon(
                Icons.send_rounded,
                color: cWhite,
              ),
            )),
      ),
    );
  }

  Row likeShare(SingleStoryResponse model, BuildContext context) {
    if (storyId == null) {
      isLike.value = model.data.isLiked;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () async {
            screenshotController.capture().then((image) async {
              if (image != null) {
                share(context, img: image);
                print('share.');
              }
            }).catchError((e) => CommanWidget.snackBar(message: 'Share Field'));
          },
          child: Column(
            children: [
              SvgPicture.asset('assets/svg/share.svg'),
              Text('Share')
            ],
          ),
        ),
      ],
    );
  }

  Expanded postImage(SingleStoryResponse model) {
    return Expanded(
      child: Screenshot(
        controller: screenshotController,
        child: PageView(
          onPageChanged: (value) {
            selectedSlideIndex.value = value;
          },
          children: model.data.storyImages
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                        color: Colors.grey.withOpacity(0.3),
                        child: e.path == null || e.path == ''
                            ? imageNotFound()
                            : commonOctoImage(
                                image: e.path, circleShape: false, fit: true)),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Padding header(SingleStoryResponse model) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          model.data?.userPic == null
              ? imageNotFound()
              : ClipOval(
                  child: commonProfileOctoImage(
                    image: model.data?.userPic,
                    height: Get.height * 0.06,
                    width: Get.height * 0.06,
                  ),
                ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.data?.userName ?? ''}',
                style: postTitleStyle(),
              ),
              Text(
                '${model.data?.userRole ?? ''}',
                style: postSubtitleStyle(),
              )
            ],
          ),
          Spacer(),
          model.data.artistId == PreferenceManager.getArtistId()
              ? deletePopupBtnMenu(model.data?.id.toString())
              : SizedBox()
        ],
      ),
    );
  }

  Future<void> onCommentTap(int id) async {
    Get.focusScope.unfocus();
    if (editingController.text.isEmpty) {
      CommanWidget.snackBar(message: 'Please Write Comment');
      return;
    }
    StoryCommentRequestModel model = StoryCommentRequestModel();
    NewStoryViewModel viewModel = Get.find();
    model.comments = editingController.text;
    model.storyId = id.toString();
    await viewModel.storyComment(model);
    if (viewModel.storyCommentApiResponse.status == Status.COMPLETE) {
      PostSuccessResponse response = viewModel.storyCommentApiResponse.data;
      if (response.message == 'comment posted') {
        CommanWidget.snackBar(message: response.message);
        Future.delayed(Duration(seconds: 2), () {
          _barController.setSelectedRoute(previousRoute);
        });
      } else {
        CommanWidget.snackBar(message: 'Server Error');
      }
    } else {
      CommanWidget.snackBar(message: 'Server Error');
    }
  }

  Future<void> onLikeTap() async {
    if (storyId == null) {
      return;
    }
    Get.focusScope.unfocus();

    StoryLikeRequestModel model = StoryLikeRequestModel();
    NewStoryViewModel viewModel = Get.find();
    model.storyId = storyId;
    model.isLiked = '0';
    await viewModel.storyLike(model);
    if (viewModel.storyLikeApiResponse.status == Status.ERROR) {
      CommanWidget.snackBar(message: 'Please try again');
    }
  }
}
