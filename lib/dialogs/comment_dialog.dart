import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/model/apiModel/requestModel/create_comment_post_request.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/services/app_notification.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

TextEditingController commentController = TextEditingController();
CommentAndLikePostViewModel createCommentViewModel = Get.find();

Future<void> commentDialog(
    {@required String title, String postId, List<String> fcmTokenList}) {
  return Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black87, width: 2),
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02, horizontal: Get.width * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Comment',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  fontSize: Get.height * 0.02),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            TextField(
              maxLines: 3,
              controller: commentController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black87, width: 2)),
                  hintText: 'Loream ipsum...',
                  hintStyle: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: Get.height * 0.016,
                      color: Colors.grey)),
              style: TextStyle(
                  fontSize: Get.height * 0.016,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins"),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            InkWell(
              onTap: () async {
                if (commentController.text == '') {
                  CommanWidget.snackBar(
                    message: "Please enter comment",
                  );
                  return;
                }
                CreateCommentPostReq createComment = CreateCommentPostReq();
                createComment.comment = commentController.text;
                createComment.postId = postId;
                createComment.commenterId =
                    PreferenceManager.getArtistId().toString();
                await createCommentViewModel.createComment(createComment);
                if (createCommentViewModel.apiResponse.status ==
                    Status.COMPLETE) {
                  PostSuccessResponse response =
                      createCommentViewModel.apiResponse.data;
                  if (response.success == true) {
                    CommanWidget.snackBar(
                      message: response.message,
                    );

                    AppNotificationHandler.sendMessage(fcmTokenList,
                        msg: 'Comment your Post');

                    Future.delayed(Duration(seconds: 2), () async {
                      Get.back();
                      commentController.clear();
                      var getLocator = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);

                      HomeTabViewModel homeTabViewModel = Get.find();

                      homeTabViewModel.getHomeFeed(
                          lat: getLocator.latitude.toString(),
                          long: getLocator.longitude.toString());
                    });
                  } else {
                    CommanWidget.snackBar(
                      message: "Comment not uploaded",
                    );
                  }
                } else {
                  CommanWidget.snackBar(
                    message: "Server Error",
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF3E5AEF),
                        Color(0xFF6C0BB9),
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                height: Get.height * 0.04,
                width: Get.width * 0.4,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.height * 0.014,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Manrope",
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
