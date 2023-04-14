import 'package:beuty_app/comman/big_profile_header.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/show_ratting_bar.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/dialogs/post_service_delete_dialog.dart';
import 'package:beuty_app/model/apiModel/responseModel/check_shop_available_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/service_by_shop_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/shopbalance_responce_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ArtistProfileServices extends StatefulWidget {
  @override
  _ArtistProfileServicesState createState() => _ArtistProfileServicesState();
}

class _ArtistProfileServicesState extends State<ArtistProfileServices> {
  BottomBarViewModel _barController = Get.find();
  HomeTabViewModel homeTabViewModel = Get.find();
  ArtistProfileViewModel artistProfileViewModel = Get.find();

  @override
  void initState() {
    super.initState();
    homeTabViewModel.serviceByShop();
    artistProfileViewModel.checkShopAvailable();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('ArtistUserProfileScreen');

        return Future.value(false);
      },
      child: Scaffold(
        appBar: customAppBar(
          'Shop',
          leadingOnTap: () {
            _barController.setSelectedRoute('ArtistUserProfileScreen');
          },
          action: svgChat(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: Get.height,
              // height: Get.height / 1.24 - .6,
              // width: Get.width,
              color: Color(0XFF03000F),
              child: Column(
                children: [
                  GetBuilder<ArtistProfileViewModel>(
                    builder: (controller) {
                      if (controller.shopBalanceApiResponse.status ==
                          Status.COMPLETE) {
                        ShopBalanceResponse response =
                            controller.shopBalanceApiResponse.data;
                        return bigProfileHeader(context,
                            route: 'ArtistUserProfileScreen',
                            balance: " ${response.data.balance ?? "0"}");
                      }
                      return bigProfileHeader(context,
                          route: 'ArtistUserProfileScreen', balance: " 0");
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListViewContainerPart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListViewContainerPart extends StatelessWidget {
  BottomBarViewModel _barController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: Get.width,
        // height: Get.height / 1.4 - 29,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: GetBuilder<ArtistProfileViewModel>(
            builder: (controller) {
              if (controller.checkShopAvailableApiResponse.status !=
                  Status.COMPLETE) {
                return Center(child: circularIndicator());
              }
              if (controller.checkShopAvailableApiResponse.status ==
                  Status.ERROR) {
                return Center(child: Text("Server Error"));
              }
              CheckShopAvailableResponse shopAvailableResponse =
                  controller.checkShopAvailableApiResponse.data;

              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (shopAvailableResponse.message ==
                              "artist has no shop") {
                            _barController.setSelectedRoute('CreateShopScreen');
                          } else {
                            _barController.setSelectedRoute('ShopView');
                          }
                        },
                        child: Text(
                          shopAvailableResponse.message == "artist has no shop"
                              ? "Create Shop"
                              : "Services",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: Get.height / 30,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (shopAvailableResponse.message ==
                              "artist has no shop") {
                            _barController.setSelectedRoute('CreateShopScreen');
                          } else {
                            _barController
                                .setSelectedRoute('AddServicesScreen');
                          }
                        },
                        child: Container(
                          height: Get.height / 13,
                          width: Get.width / 6,
                          //color: Colors.deepOrange,
                          child: SvgPicture.asset(
                            "assets/svg/round_button.svg",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GetBuilder<HomeTabViewModel>(
                      builder: (controller) {
                        if (controller.serviceByShopApiResponse.status !=
                            Status.COMPLETE) {
                          return Center(child: circularIndicator());
                        }
                        if (controller.serviceByShopApiResponse.status ==
                            Status.ERROR) {
                          return Center(child: Text("Server Error"));
                        }

                        ServiceByShopResponse response =
                            controller.serviceByShopApiResponse.data;
                        if (response.data.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Text('Data not found'),
                          );
                        }
                        return Container(
                          height: Get.height / 1.8 - 6,
                          width: Get.width,
                          //color: Colors.blueAccent,
                          child: ListView.builder(
                            itemCount: response.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: MaterialButton(
                                  onPressed: () {
                                    serviceDeleteDialog(
                                      context,
                                      id: response.data[index].id.toString(),
                                      serviceName:
                                          response.data[index].serviceName,
                                      price: response.data[index].price,
                                      rate: response.data[index].serviceRating
                                              ?.toDouble() ??
                                          1.0,
                                      image: response.data[index].image,
                                      description:
                                          response.data[index].description,
                                      time:
                                          "${response.data[index].createdAt.hour.toString().padLeft(2, "0") ?? ""}:${response.data[index].createdAt.minute.toString().padLeft(2, "0") ?? ""}:${response.data[index].createdAt.second.toString().padLeft(2, "0") ?? ""}",
                                      date:
                                          "${response.data[index].createdAt.year ?? ""}-${response.data[index].createdAt.month.toString().padLeft(2, "0") ?? ""}-${response.data[index].createdAt.day.toString().padLeft(2, "0") ?? ""}",
                                    );
                                  },
                                  child: Container(
                                    height: Get.height / 8,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 1)
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        response.data[index].image == null ||
                                                response.data[index].image == ''
                                            ? imageNotFound()
                                            : ClipOval(
                                                child: commonProfileOctoImage(
                                                  image: response
                                                      .data[index].image,
                                                  height: Get.height * 0.06,
                                                  width: Get.height * 0.06,
                                                ),
                                              ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              response.data[index]
                                                      .serviceName ??
                                                  "",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: Get.height * 0.02,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "Hair",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xffBBBDC1)),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "\$${response.data[index].price ?? ""}",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black),
                                            ),
                                            showRattingBar(),
                                          ],
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${response.data[index].createdAt.year ?? ""}-${response.data[index].createdAt.month.toString().padLeft(2, "0") ?? ""}-${response.data[index].createdAt.day.toString().padLeft(2, "0") ?? ""}",
                                                style: TextStyle(
                                                    fontSize:
                                                        Get.height * 0.017,
                                                    color: Color(0xff080A0C)),
                                              ),
                                              Text(
                                                "${response.data[index].createdAt.hour.toString().padLeft(2, "0") ?? ""}:${response.data[index].createdAt.minute.toString().padLeft(2, "0") ?? ""}",
                                                style: TextStyle(
                                                    fontSize:
                                                        Get.height * 0.017,
                                                    color: Color(0xff080A0C)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // color: Colors.blue,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
