import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/favorite.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/small_profile_header.dart';
import 'package:beuty_app/dialogs/favourite_dialog.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/check_isliked_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllFavoritesScreen extends StatefulWidget {
  @override
  _AllFavoritesScreenState createState() => _AllFavoritesScreenState();
}

class _AllFavoritesScreenState extends State<AllFavoritesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: customAppBar(
          'Favorites',
          leadingOnTap: () {
            Get.back();
          },
        ),
        backgroundColor: cDarkBlue,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              GetBuilder<ArtistProfileViewModel>(
                builder: (controller) {
                  if (controller.artistProfileApiResponse.status ==
                      Status.COMPLETE) {
                    ArtistProfileDetailResponse response =
                        controller.artistProfileApiResponse.data;
                    return smallProfileHeader(
                        name: response.data.username,
                        subName: response.data.role ?? '',
                        imageUrl: response.data.image,
                        showPopup: false);
                  }
                  if (controller.artistProfileApiResponse.status ==
                      Status.ERROR) {
                    return Center(
                      child: Text('Server Error'),
                    );
                  }
                  return circularIndicator();
                },
              ),
              SizedBox(
                height: 15,
              ),
              centerBody()
            ],
          ),
        ),
      ),
    );
  }

  Expanded centerBody() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(35),
            )),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: PreferenceManager.getFavorite() == null
                  ? Center(
                      child: Text('No have any favorite'),
                    )
                  : PreferenceManager.getFavorite().length == 0
                      ? Center(
                          child: Text('No have any favorite'),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: PreferenceManager.getFavorite()
                                .map((e) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.height * 0.023),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.005,
                                          ),
                                          Container(
                                            height: Get.height * 0.09,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 5)
                                                ]),
                                            child: ListTile(
                                              onTap: () async {
                                                CommentAndLikePostViewModel
                                                    likeViewModel = Get.find();
                                                await likeViewModel
                                                    .getCheckPostLiked(
                                                  e["id"].toString(),
                                                );
                                                bool likeStatus = false;
                                                if (likeViewModel
                                                        .checkIsLikedApiResponse
                                                        .status ==
                                                    Status.COMPLETE) {
                                                  CheckIsLikedResponse likeRes =
                                                      likeViewModel
                                                          .checkIsLikedApiResponse
                                                          .data;
                                                  likeStatus =
                                                      likeRes.data.liked;
                                                }
                                                favouriteItemDialog(
                                                    postId: e["id"],
                                                    likeStatus: likeStatus,
                                                    price: e["price"] ?? "",
                                                    serviceCategoryName:
                                                        e['subTitle'] ?? "",
                                                    description:
                                                        e['description'] ?? "",
                                                    image: e['image'] ?? "",
                                                    serviceName: e["title"]);
                                              },
                                              leading: e['image'] == null ||
                                                      e['image'] == ''
                                                  ? imageNotFound()
                                                  : ClipOval(
                                                      child:
                                                          commonProfileOctoImage(
                                                        image: e['image'],
                                                        height:
                                                            Get.height * 0.05,
                                                        width:
                                                            Get.height * 0.05,
                                                      ),
                                                    ),
                                              trailing: GestureDetector(
                                                onTap: () async {
                                                  await addFavorite(
                                                      id: e['id'],
                                                      title: e['title'],
                                                      subTitle: e['subTitle']);
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              title: Text(
                                                "${e['title']}",
                                                style: TextStyle(
                                                    fontSize:
                                                        Get.height * 0.018,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Poppins"),
                                              ),
                                              subtitle: Text(
                                                "${e['subTitle']}",
                                                style: TextStyle(
                                                    fontSize:
                                                        Get.height * 0.014,
                                                    fontFamily: "Poppins"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          )
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }

  Text artistType() {
    return Text(
      PreferenceManager.getCustomerRole() ?? '',
      style: TextStyle(
          color: cLightGrey,
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400),
    );
  }

  Text profileName() {
    return Text(
      PreferenceManager.getUserName() ?? '',
      style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600),
    );
  }

  Widget profileImage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Stack(
        children: [
          CircleAvatar(
            child: Image.asset('assets/image/userprofile.png'),
            radius: Get.height * 0.03,
          ),
          Positioned(
            top: Get.height * 0.002,
            right: Get.height * 0.003,
            child: Container(
              height: Get.height * 0.02,
              width: Get.width * 0.03,
              decoration: BoxDecoration(
                  color: cGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2)),
            ),
          )
        ],
      ),
    );
  }
}
