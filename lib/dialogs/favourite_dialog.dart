import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/share_method.dart';
import 'package:beuty_app/comman/show_ratting_bar.dart';
import 'package:beuty_app/dialogs/comment_dialog.dart';
import 'package:beuty_app/model/apiModel/requestModel/likepost_request_model.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

CommentAndLikePostViewModel likePostViewModel = Get.find();

Future<void> favouriteItemDialog(
    {bool isOnTap = false,
    String postId,
    String serviceName,
    String serviceCategoryName,
    String price,
    String description,
    double rating,
    String image,
    bool likeStatus}) {
  bool _isLike = likeStatus;

  return Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),

    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: StatefulBuilder(builder: (context, dialogSetState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          topImageView(image),
          SizedBox(
            height: Get.height * 0.01,
          ),
          specificationView(description),
          SizedBox(
            height: Get.height * 0.03,
          ),
          bottomRow(_isLike, postId),
          SizedBox(
            height: Get.height * 0.01,
          ),
        ],
      );
    }),
  ));
}

Padding centerView(bool isSelected, String serviceName,
    String serviceCategoryName, String price, double rating,
    {Function onTap}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: Get.height * 0.02, horizontal: Get.width * 0.03),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              serviceName ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  fontSize: Get.height * 0.018),
            ),
            Spacer(),
            InkWell(
              onTap: onTap,
              child: !isSelected
                  ? Icon(
                      Icons.favorite_border,
                      color: Color(0xff424BE1),
                    )
                  : Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
            )
          ],
        ),
        showRattingBar(),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Container(
          width: Get.width * 0.2,
          height: Get.height * 0.035,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.black, width: 1)),
          child: Text(
            '\$${price}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              fontSize: Get.height * 0.025,
            ),
          ),
        ),
      ],
    ),
  );
}

bottomRow(bool _isLike, String postId) {
  return StatefulBuilder(
    builder: (BuildContext context, dialogSetState) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {
              dialogSetState(() {
                _isLike = !_isLike;
              });
              IsLikedPostReq isLike = IsLikedPostReq();
              isLike.postId = postId.toString();
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
              commentDialog(title: 'Submit', postId: postId);
            },
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/svg/comment.svg",
                ),
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
                SvgPicture
                    .asset('assets/svg/share.svg'),
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

Padding specificationView(
  String description,
) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specification',
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: Get.height * 0.02,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Text(
          description ?? '',
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.grey,
              fontSize: Get.height * 0.014,
              fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}

// Container topItemImagelist() {
//   return Container(
//     height: Get.height * 0.07,
//     width: Get.width,
//     alignment: Alignment.center,
//     child: SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: listImg
//             .map((e) => Padding(
//           padding: EdgeInsets.symmetric(horizontal: Get.width * 0.015),
//           child: Container(
//             decoration: BoxDecoration(
//                 image: DecorationImage(image: e[KeyPointer.img]),
//                 borderRadius: BorderRadius.circular(10)),
//             height: Get.height * 0.07,
//             width: Get.height * 0.07,
//           ),
//         ))
//             .toList(),
//       ),
//     ),
//   );
// }

Stack topImageView(String image) {
  return Stack(
    children: [
      /* Container(
        width: Get.width,
        height: Get.height * 0.225,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Image.asset(
          'assets/image/shopitembannerimg.png',
          fit: BoxFit.fill,
        ),
      ),*/
      image == null || image == ''
          ? imageNotLoadRectangle()
          : ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.grey.withOpacity(0.3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: commonOctoImage(
                    image: image,
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
      )
    ],
  );
}

// Widget bookNow() {
//   return Padding(
//     padding: EdgeInsets.only(top: Get.height * 0.02),
//     child: InkWell(
//       onTap: () {
//         Get.back();
//         BottomBarViewModel _barController = Get.find();
//         _barController.setSelectedRoute('BookAppointmentScreen');
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(
//               colors: [
//                 Color(0xFF3E5AEF),
//                 Color(0xFF6C0BB9),
//               ],
//               begin: const FractionalOffset(0.0, 0.0),
//               end: const FractionalOffset(1.0, 0.0),
//               stops: [0.0, 1.0],
//               tileMode: TileMode.clamp),
//         ),
//         height: Get.height * 0.04,
//         width: Get.width * 0.4,
//         child: Center(
//           child: Text(
//             'BOOK NOW',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: Get.height * 0.014,
//               fontWeight: FontWeight.w700,
//               fontFamily: "Manrope",
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
