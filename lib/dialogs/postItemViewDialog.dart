import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/share_method.dart';
import 'package:beuty_app/dialogs/comment_dialog.dart';
import 'package:beuty_app/model/apiModel/requestModel/likepost_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_post_response_model.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

enum KeyPointer { img }

CommentAndLikePostViewModel likePostViewModel = Get.find();
bool _isSelected = false;
bool _isLike = false;

Widget bottomRow(
  ArtistPostDatum response,
) {
  return StatefulBuilder(
    builder: (context, dialogSetState) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {
              dialogSetState(() {
                _isLike = !_isLike;
              });
              IsLikedPostReq isLike = IsLikedPostReq();
              isLike.postId = response.id.toString();
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
              commentDialog(title: 'Submit', postId: response.id.toString());
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
    },
  );
}

Padding specification(ArtistPostDatum response) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
    child: Text(
      response.contentType ?? '',
      style: TextStyle(
          fontFamily: "Poppins",
          color: Colors.grey,
          fontSize: Get.height * 0.014,
          fontWeight: FontWeight.w400),
    ),
  );
}

Padding dummyNailRow(ArtistPostDatum response) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: Get.height * 0.02, horizontal: Get.width * 0.03),
    child: StatefulBuilder(
      builder: (context, dialogSetstate) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    response.statusText ?? '',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: Get.height * 0.018),
                  ),
                ),

                // InkWell(
                //   onTap: () async {
                //     dialogSetstate(() {
                //       _isSelected = !_isSelected;
                //     });
                //     IsFavoriteReq model = IsFavoriteReq();
                //     model.postId = response.id.toString();
                //     model.isFav = _isSelected ? '1' : '0';
                //     await likePostViewModel.isFavorite(model);
                //     await addFavorite(
                //         id: response.id.toString(),
                //         title: response.statusText,
                //         subTitle: response.contentType,
                //         image: response.feedImage.isEmpty
                //             ? null
                //             : response.feedImage[0].path);
                //   },
                //   child: !_isSelected
                //       ? Icon(
                //           Icons.favorite_border,
                //           color: Color(0xff424BE1),
                //         )
                //       : Icon(
                //           Icons.favorite,
                //           color: Colors.red,
                //         ),
                // ),
              ],
            ),
            // showRattingBar(response.favouriteId ?? 0.0),
          ],
        );
      },
    ),
  );
}

Padding topItemList(List<FeedImage> feedImage) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
    child: Container(
      height: Get.height * 0.07,
      width: Get.width,
      alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: feedImage
            .map((e) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.015),
                  child: e.path == null || e.path == ''
                      ? imageNotFound()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            color: Colors.grey.withOpacity(0.3),
                            child: commonOctoImage(
                                image: e.path,
                                height: Get.height * 0.07,
                                width: Get.height * 0.07,
                                circleShape: false,
                                fit: true),
                          ),
                        ),
                ))
            .toList(),
      ),
    ),
  );
}

Stack topImageView(List<FeedImage> feedImage) {
  return Stack(
    children: [
      feedImage.isEmpty
          ? imageNotLoadRectangle()
          : feedImage[0].path == null || feedImage[0].path == ''
              ? imageNotLoadRectangle()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.grey.withOpacity(0.3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: commonOctoImage(
                        image: feedImage[0].path,
                        width: Get.width,
                        height: Get.height * 0.225,
                        circleShape: false,
                      ),
                    ),
                  ),
                ),
      Positioned(
        top: Get.height * 0.01,
        right: Get.width * 0.02,
        child: InkWell(
          onTap: () async {
            Get.back();
          },
          child: CircleAvatar(
            radius: Get.height * 0.016,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.clear,
              color: Color(0xff424BE1),
            ),
          ),
        ),
      ),
    ],
  );
}

Future<void> postItemDialog(
    ArtistPostDatum response, bool likeStatus, bool isFavorite) {
  _isLike = likeStatus;
  _isSelected = isFavorite;
  return Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),

    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.01, horizontal: Get.width * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          topImageView(response.feedImage),
          SizedBox(
            height: Get.height * 0.01,
          ),
          topItemList(response.feedImage),
          dummyNailRow(response),
          specification(response),
          SizedBox(
            height: Get.height * 0.03,
          ),
          bottomRow(
            response,
          )
        ],
      ),
    ),
  ));
}
