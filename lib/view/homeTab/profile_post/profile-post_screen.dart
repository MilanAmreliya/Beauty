import 'dart:developer' as log;
import 'dart:math';

import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/shop_service_stack_product_box.dart';
import 'package:beuty_app/comman/show_ratting_bar.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/comman/user_uper_data.dart';
import 'package:beuty_app/dialogs/postItemViewDialog.dart';
import 'package:beuty_app/model/apiModel/requestModel/follow_person_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/single_post_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_post_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/check_isliked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/service_by_shop_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/view/bottomBar/widgets/bottom_navigation_bar.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:beuty_app/viewModel/model_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:beuty_app/comman/images.dart';
import 'package:beuty_app/dialogs/serviceItemDialog.dart';
import 'package:beuty_app/comman/favorite.dart';
import 'package:beuty_app/model/apiModel/requestModel/selected_service_model.dart';

List beautyType = ["Hair", "NailPolish", "Mask", "Lipstick"];

PageController pageController = PageController();

class ProfilePostScreen extends StatefulWidget {
  final String previousRoute;
  final String singlePostScreenRoute;

  const ProfilePostScreen(
      {Key key, this.previousRoute, this.singlePostScreenRoute})
      : super(key: key);
  @override
  _ProfilePostScreenState createState() => _ProfilePostScreenState();
}

class _ProfilePostScreenState extends State<ProfilePostScreen> {
  BottomBarViewModel _barController = Get.find();
  ArtistProfileViewModel artistProfileViewModel = Get.find();
  HomeTabViewModel homeTabViewModel = Get.find();
  CommentAndLikePostViewModel likeViewModel = Get.find();
  RxInt currentIndex = 0.obs;
  RxInt selectedPage = 0.obs;
  bool isSelected = false;
  List<StaggeredTile> tiles = <StaggeredTile>[];
  ModelProfileViewModel modelProfileViewModel = Get.find();

  @override
  void initState() {
    super.initState();

    print('selectedArtistId=>${_barController.selectedArtistId.value}');
    artistProfileViewModel
        .getShopByCreate("${_barController.selectedArtistId.value}")
        .then((value) => homeTabViewModel.serviceByShop());

    homeTabViewModel
        .getArtistPost(_barController.selectedArtistId.value.toString());

    artistProfileViewModel.getProfileDetail(
        artistId: "${_barController.selectedArtistId.value}");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute(widget.previousRoute);

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cDarkBlue,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: GetBuilder<ArtistProfileViewModel>(
            builder: (controller) {
              if (controller.artistProfileApiResponse.status !=
                  Status.COMPLETE) {
                return customAppBar(
                  '',
                  leadingOnTap: () {
                    _barController.setSelectedRoute(widget.previousRoute);
                  },
                  action: svgChat(),
                );
              }
              ArtistProfileDetailResponse response =
                  controller.artistProfileApiResponse.data;
              return customAppBar(
                response.data.username ?? '',
                leadingOnTap: () {
                  _barController.setSelectedRoute(widget.previousRoute);
                },
                action: svgChat(),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                userProfile(),
                SizedBox(
                  height: 20,
                ),
                postAndShopImage()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget postAndShopImage() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.02),
                child: Obx(() {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          selectedPage.value == 1
                              ? GestureDetector(
                                  onTap: () {
                                    pageController.previousPage(
                                        duration: Duration(seconds: 1),
                                        curve: Curves.ease);
                                  },
                                  child: Icon(
                                    Icons.navigate_before,
                                    size: Get.height * 0.033,
                                    color: cRoyalBlue,
                                  ),
                                )
                              : SizedBox(),
                          Padding(
                            padding: selectedPage.value == 1
                                ? EdgeInsets.only(right: Get.height * 0.035)
                                : EdgeInsets.only(left: Get.height * 0.035),
                            child: Text(
                              selectedPage.value == 1 ? "Services" : "Post",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.black,
                                  fontSize: Get.height * 0.03,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          selectedPage.value == 1
                              ? sizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    pageController.nextPage(
                                        duration: Duration(seconds: 1),
                                        curve: Curves.ease);
                                  },
                                  child: Icon(
                                    Icons.navigate_next_outlined,
                                    size: Get.height * 0.033,
                                    color: cRoyalBlue,
                                  ),
                                )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            2,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(left: 7),
                                  child: Container(
                                    height: Get.height * 0.007,
                                    width: selectedPage.value == index
                                        ? Get.width * 0.05
                                        : Get.width * 0.02,
                                    decoration: BoxDecoration(
                                        color: cRoyalBlue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                )),
                      )
                    ],
                  );
                })),
            SizedBox(
              height: Get.height * 0.012,
            ),
            Expanded(
              child: PageView(
                onPageChanged: (val) {
                  selectedPage.value = val;
                },
                controller: pageController,
                children: [
                  postWidget(),
                  shopWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column shopWidget() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.012,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.height * 0.02),
            child: GetBuilder<HomeTabViewModel>(
              builder: (controller) {
                if (controller.serviceByShopApiResponse.status ==
                    Status.LOADING) {
                  return Center(child: circularIndicator());
                }
                if (controller.serviceByShopApiResponse.status ==
                    Status.ERROR) {
                  return Center(
                    child: Text('Server Error'),
                  );
                }

                ServiceByShopResponse response =
                    controller.serviceByShopApiResponse.data;
                if (response.data.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      'Service not available',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                  );
                }

                return Container(
                    child: GridView.builder(
                        itemCount: response.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: Get.height * 0.015,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: Get.height * 0.015,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              onTap(response, index);
                            },
                            child: shopServiceStackProductBox(
                              serviceCat: response.data[index] == null
                                  ? ""
                                  : response.data[index].serviceCategory == null
                                      ? ""
                                      : response.data[index].serviceCategory
                                          .serviceCategoryName,
                              serviceName: response.data[index] == null
                                  ? ""
                                  : response.data[index].serviceName,
                              price: response.data[index] == null
                                  ? ""
                                  : "\$${response.data[index].price}",
                              img: response.data[index] == null
                                  ? ""
                                  : response.data[index].image,
                            ),
                          );
                        }));
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onTap(ServiceByShopResponse response, int index) async {
    SelectedServiceModel _serviceModel = SelectedServiceModel();

    response.data.forEach((element) {
      if (element.id == element.id) {
        _serviceModel.price = element.price;
        _serviceModel.image = element.image;
        _serviceModel.id = element.id.toString();
        _serviceModel.endTime = element.endTime;
        _serviceModel.startTime = element.startTime;
        _serviceModel.description = element.description;
        _serviceModel.artistId = element.artistId.toString();
      }
    });

    await likeViewModel.getCheckPostLiked(
      response.data[index].id.toString(),
    );
    bool likeStatus;
    bool favoriteStatus = false;
    if (likeViewModel.checkIsLikedApiResponse.status == Status.COMPLETE) {
      CheckIsLikedResponse likeRes = likeViewModel.checkIsLikedApiResponse.data;
      likeStatus = likeRes.data.liked;
    }
    print('like status:$likeStatus');

    favoriteStatus = checkFavorite(response.data[index].id.toString());
    serviceItemDialog(
        isFavorite: favoriteStatus,
        postId: response.data[index].id.toString(),
        serviceName: response.data[index].serviceName,
        price: response.data[index].price,
        description: response.data[index].description,
        serviceCategoryName:
            response.data[index].serviceCategory.serviceCategoryName,
        rating: response.data[index].serviceRating?.toDouble() ?? 0.0,
        image: response.data[index].image,
        likeStatus: likeStatus);
  }

  Column postWidget() {
    return Column(
      children: [
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //       children: List.generate(
        //           beautyType.length,
        //           (index) => Padding(
        //                 padding: EdgeInsets.only(left: Get.height * 0.025),
        //                 child: GestureDetector(onTap: () {
        //                   currentIndex.value = index;
        //                 }, child: Obx(() {
        //                   return Container(
        //                     height: Get.height * 0.027,
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(10),
        //                       border: Border.all(
        //                           color: currentIndex.value == index
        //                               ? cRoyalBlue
        //                               : cLightGrey),
        //                     ),
        //                     child: Padding(
        //                       padding: EdgeInsets.symmetric(
        //                           horizontal: Get.height * 0.012),
        //                       child: Text(
        //                         beautyType[index],
        //                         style: TextStyle(
        //                             fontSize: Get.height * 0.016,
        //                             color: currentIndex.value == index
        //                                 ? cRoyalBlue
        //                                 : cLightGrey,
        //                             fontWeight: FontWeight.bold,
        //                             fontFamily: "Manrope"),
        //                       ),
        //                     ),
        //                   );
        //                 })),
        //               ))),
        // ),
        SizedBox(
          height: Get.height * 0.012,
        ),
        Expanded(
          child: GetBuilder<HomeTabViewModel>(
            builder: (controller) {
              if (controller.artistPostApiResponse.status == Status.LOADING) {
                return Center(child: circularIndicator());
              }
              if (controller.artistPostApiResponse.status == Status.ERROR) {
                return Center(
                  child: Text('Server Error'),
                );
              }
              ArtistPostResponse response =
                  controller.artistPostApiResponse.data;
              if (response.data.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    'Post not available',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                );
              }
              response.data.forEach((element) {
                tiles.add(Random().nextInt(2) == 1
                    ? StaggeredTile.count(1, 1.5)
                    : StaggeredTile.count(1, 1));
              });
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.022),
                child: Container(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 3,
                    mainAxisSpacing: Get.height * 0.02,
                    crossAxisSpacing: Get.height * 0.02,

                    itemCount: response.data.length,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () {
                        log.log("IS CALLLLLLLL");
                        onTapSinglePost(response, index);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.grey.withOpacity(0.3),
                          child: response.data[index].feedImage.isEmpty
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  child: Center(child: Text('Image not load')),
                                )
                              : response.data[index].feedImage[0].path == null
                                  ? imageNotFound()
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: commonOctoImage(
                                          image: response
                                              .data[index].feedImage[0].path,
                                          circleShape: false,
                                          fit: true),
                                    ),
                        ),
                      ),
                      /*  child: new Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/image/img1.jpg",
                                ),
                                fit: BoxFit.cover)),
                      ),*/
                    ),
                    staggeredTileBuilder: (int index) {
                      return index >= tiles.length ? null : tiles[index];
                    },
                    // mainAxisSpacing: 3.0,
                    // crossAxisSpacing: 3.0,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Image rattingStar() {
    return Image.asset(
      'assets/image/star.png',
      height: Get.height * 0.02,
    );
  }

  SizedBox sizedBox() {
    return SizedBox(
      height: Get.height * 0.005,
    );
  }

  Widget userProfile() {
    return GetBuilder<ArtistProfileViewModel>(
      builder: (controller) {
        if (controller.artistProfileApiResponse.status == Status.LOADING) {
          return circularIndicator();
        }
        if (controller.artistProfileApiResponse.status == Status.ERROR) {
          return Center(
            child: Text('Server Error'),
          );
        }
        ArtistProfileDetailResponse response =
            controller.artistProfileApiResponse.data;
        return Column(
          children: [
            response.data.image == null || response.data.image == ''
                ? imageNotFound()
                : ClipOval(
                    child: commonProfileOctoImage(
                      image: response.data.image,
                      height: Get.height * 0.1,
                      width: Get.height * 0.1,
                    ),
                  ),
            SizedBox(
              height: 8,
            ),
            Text(
              response.data.username ?? '',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
            Text(
              response.data.role ?? '',
              style: TextStyle(
                  color: cLightGrey,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 5,
            ),
            /* showRattingBar(response.data.review.toDouble() ?? ""),*/
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Spacer(),
                userData("Follower", '${response.data.followerCount}'),
                Spacer(),
                /* userData("Following", '${response.data.followingCount}'),
                Spacer(),*/
                userData("Posts", '${response.data.postCount}'),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(response.data.bio ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400)),
            SizedBox(
              height: 25,
            ),
          ],
        );
      },
    );
  }

  Widget followButton() {
    return customBtn(
        height: Get.height * 0.04,
        width: Get.width * 0.3,
        title: !isSelected ? 'Follow' : "Following",
        radius: 35,
        onTap: () async {
          setState(() {
            isSelected = !isSelected;
          });
          FollowPersonRequestModel requestModel = FollowPersonRequestModel();
          requestModel.followerId =
              _barController.selectedArtistId.value.toString();
          requestModel.isFollowing = '0';
          await homeTabViewModel.createFollowPerson(requestModel);
          if (homeTabViewModel.followPersonApiResponse.status ==
              Status.COMPLETE) {
            PostSuccessResponse res =
                homeTabViewModel.followPersonApiResponse.data;
            if (!res.success) {
              CommanWidget.snackBar(message: "Server Error");
            } else {
              CommanWidget.snackBar(message: res.message);
            }
          } else {
            CommanWidget.snackBar(message: "Server Error");
          }
        });
  }

  Padding followAndBookButton() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.height * 0.03),
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  currentIndex.value = 0;
                },
                child: currentIndex.value == 0
                    ? GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: Get.height * 0.04,
                          width: Get.width * 0.5,
                          //  margin: EdgeInsets.symmetric(horizontal: 50),
                          // width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: cRoyalBlue,
                              borderRadius: BorderRadius.circular(35),
                              gradient: LinearGradient(colors: [
                                Color(0xff3E5AEF),
                                Color(0xff6C0BB9),
                              ])),
                          child: Center(
                            child: Text(
                              "Book An Appoinment",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Get.height * 0.017),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: Get.height * 0.04,
                        width: Get.width * 0.5,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Book An Appoinment",
                            style: TextStyle(
                                color: cWhite, fontSize: Get.height * 0.017),
                          ),
                        ),
                      ),
              ),
              /*GestureDetector(
                onTap: () {
                  currentIndex.value = 1;
                },
                child: currentIndex.value == 1
                    ? Container(
                        height: Get.height * 0.04,
                        width: Get.width * 0.3,
                        //  margin: EdgeInsets.symmetric(horizontal: 50),
                        // width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: cRoyalBlue,
                            borderRadius: BorderRadius.circular(35),
                            gradient: LinearGradient(colors: [
                              Color(0xff3E5AEF),
                              Color(0xff6C0BB9),
                            ])),
                        child: Center(
                          child: Text(
                            "Follow",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: Get.height * 0.017),
                          ),
                        ),
                      )
                    : Container(
                        height: Get.height * 0.04,
                        width: Get.width * 0.3,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Follow",
                            style: TextStyle(
                                color: cWhite, fontSize: Get.height * 0.017),
                          ),
                        ),
                      ),
              ),*/
            ],
          );
        }));
  }

  Future<void> onTapSinglePost(ArtistPostResponse response, int index) async {
    ///check like or not
    CommentAndLikePostViewModel likeViewModel = Get.find();
    await likeViewModel.getCheckPostLiked(
      response.data[index].id.toString(),
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
    response.deviceToken.forEach((element) {
      listDeviceToken.add(element.deviceToken);
    });
    response.data[index].feedImage.forEach((element) {
      list.add(element.path);
    });
    SinglePostRequestModel requestModel = SinglePostRequestModel();
    requestModel.artistId = response.data[index].customerId.toString();
    requestModel.postImg = list;
    requestModel.postId = response.data[index].id.toString();
    requestModel.isLike = likeStatus;
    requestModel.address=response.shop[0].address;
    requestModel.deviceTokens = listDeviceToken;

    BottomBarViewModel _bottomBarViewModel = Get.find();
    _bottomBarViewModel.setSelectedRoute(widget.singlePostScreenRoute);
  }
}
