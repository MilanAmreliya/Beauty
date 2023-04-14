
import 'package:beuty_app/comman/box_decoration.dart';
import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/comman/home_tab_process_indecator.dart';
import 'package:beuty_app/model/apiModel/requestModel/post_edit_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/single_post_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_edit_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPostScreen extends StatefulWidget {
  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  BottomBarViewModel _barController = Get.find();
  EditPostRequestModel _model = EditPostRequestModel();
  HomeTabViewModel _homeTabViewModel = Get.find();

  RxInt selectedSlideIndex = 0.obs;

  TextEditingController messageController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ArtistProfileViewModel controller = Get.find();

  PageController pageViewController = PageController();
  int _currentPosition = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageController.text = _model.statusText;
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
        appBar: customAppBar('Edit Post', leadingOnTap: () {
          _barController.setSelectedRoute('ArtistUserProfileScreen');
        }),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40)),
                child: Container(
                  height: Get.height * 0.5,
                  width: Get.width,
                  decoration: bottomRadiusDecoration(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        // selectedImg(),
                        Column(
                          children: [
                            Container(
                                height: Get.height * 0.33,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20)),
                                child: PageView(
                                  controller: pageViewController,
                                  children: List.generate(_model.postImg.length,
                                      (index) {
                                    return _model.postImg == null ||
                                            _model.postImg == ''
                                        ? imageNotLoadRectangle()
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: commonOctoImage(
                                                image: _model.postImg[index],
                                                circleShape: false,
                                                width: Get.width));
                                  }),
                                  onPageChanged: (int index) {
                                    setState(() {
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
                                  Spacer(),
                                  _model.postImg.length == 1
                                      ? SizedBox()
                                      : Row(
                                          children: List.generate(
                                              _model.postImg.length, (index) {
                                            return Padding(
                                              padding: EdgeInsets.all(
                                                  Get.width * 0.005),
                                              child: CircleAvatar(
                                                radius: Get.height * 0.005,
                                                backgroundColor:
                                                    index == _currentPosition
                                                        ? Color(0xff424BE1)
                                                        : Colors.grey,
                                              ),
                                            );
                                          }),
                                        ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ],
                        ),

                        commentTextField()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.05),
              child: customBtn(
                  title: 'Update',
                  onTap: () async {
                    if (formKey.currentState.validate()) {
                      PostEditReq postEditReq = PostEditReq();
                      postEditReq.statusText = messageController.text;
                      postEditReq.statusHeadline = "";
                      await controller.editPost(postEditReq, _model.postId);
                      if (controller.editPostApiResponse.status ==
                          Status.COMPLETE) {
                        PostEditResponse response =
                            controller.editPostApiResponse.data;
                        if (response.success) {
                          CommanWidget.snackBar(
                            message: response.message,
                          );

                          Future.delayed(Duration(seconds: 1), () {
                            _barController
                                .setSelectedRoute('ArtistUserProfileScreen');
                            controller.clearGetPostData();
                          });
                        } else {
                          CommanWidget.snackBar(
                            message: "Post not updated",
                          );
                        }
                      } else {
                        CommanWidget.snackBar(
                          message: "Server Error",
                        );
                      }
                    }
                  }),
            )
          ],
        ),
        homeTabProcessIndicator()
      ],
    );
  }

  Widget commentTextField() {
    return Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: cLightGrey),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                maxLines: 4,
                validator: (value) {
                  if (value.isEmpty) {
                    return '* Required';
                  }
                  return null;
                },
                controller: messageController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write Status Text..',
                    hintStyle: TextStyle(color: cDarkGrey)),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   decoration: BoxDecoration(
            //       border: Border.all(color: cLightGrey),
            //       borderRadius: BorderRadius.circular(10)),
            //   child: TextFormField(
            //     maxLines: 3,
            //     validator: (value) {
            //       if (value.isEmpty) {
            //         return '* Required';
            //       }
            //       return null;
            //     },
            //     controller: contentController,
            //     decoration: InputDecoration(
            //         border: InputBorder.none,
            //         hintText: 'Write Status Headline',
            //         hintStyle: TextStyle(color: cDarkGrey)),
            //   ),
            // ),
          ],
        ));
  }

  Container imageShow(dynamic i) {
    return Container(
      width: Get.width,
      height: Get.height * 0.3,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(i),
            fit: BoxFit.cover,
          )),
    );
  }
}
