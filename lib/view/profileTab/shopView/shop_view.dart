import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/show_ratting_bar.dart';
import 'package:beuty_app/comman/small_profile_header.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/dialogs/post_service_delete_dialog.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/service_by_shop_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ShopView extends StatefulWidget {
  @override
  _ShopViewState createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  BottomBarViewModel _barController = Get.find();
  HomeTabViewModel homeTabViewModel = Get.find();

  @override
  void initState() {
    super.initState();
    homeTabViewModel.serviceByShop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('ArtistProfileServices');

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Color(0XFF03000F),
        appBar: customAppBar(
          'Shop',
          leadingOnTap: () {
            _barController.setSelectedRoute('ArtistProfileServices');
          },
          action: svgChat(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              GetBuilder<ArtistProfileViewModel>(
                builder: (controller) {
                  if (controller.artistProfileApiResponse.status ==
                      Status.COMPLETE) {
                    ArtistProfileDetailResponse response =
                        controller.artistProfileApiResponse.data;
                    return smallProfileHeader(
                        name: response.data.username ?? '',
                        subName: response.data.role ?? "",
                        imageUrl: response.data.image);
                  }
                  return loadingIndicator();
                },
              ),
              SizedBox(
                height: 15,
              ),
              ListViewPart(),
            ],
          ),
        ),
      ),
    );
  }
}

class ListViewPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: Get.width,
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
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: Get.width / 2.7,
                  ),
                  Text(
                    "Services",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: Get.height / 30,
                        fontFamily: 'Poppins'),
                  ),
                  SizedBox(
                    width: Get.width / 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      BottomBarViewModel _barController = Get.find();
                      _barController.setSelectedRoute('AddServicesScreen');
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
                height: 10,
              ),
              Expanded(
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
                                  serviceName: response.data[index].serviceName,
                                  price: response.data[index].price,
                                  rate: response.data[index].serviceRating
                                          ?.toDouble() ??
                                      1.0,
                                  image: response.data[index].image,
                                  description: response.data[index].description,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/image/card1.png",
                                          height: Get.height * 0.08,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          response.data[index].serviceName ??
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
                                      width: Get.width * 0.01,
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
                                        showRattingBar(
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${response.data[index].createdAt.year ?? ""}-${response.data[index].createdAt.month.toString().padLeft(2, "0") ?? ""}-${response.data[index].createdAt.day.toString().padLeft(2, "0") ?? ""}",
                                            style: TextStyle(
                                                fontSize: Get.height * 0.017,
                                                color: Color(0xff080A0C)),
                                          ),
                                          Text(
                                            "${response.data[index].createdAt.hour.toString().padLeft(2, "0") ?? ""}:${response.data[index].createdAt.minute.toString().padLeft(2, "0") ?? ""}",
                                            style: TextStyle(
                                                fontSize: Get.height * 0.017,
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
          ),
        ),
      ),
    );
  }
}
