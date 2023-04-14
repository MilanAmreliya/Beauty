import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/dialogs/withrawDialog.dart';
import 'package:beuty_app/model/apiModel/responseModel/shopbalance_responce_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/chat__viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'widgets/balance_part.dart';
import 'widgets/slider_up_panel_body.dart';
import 'widgets/withdrawal_part.dart';

class Balance extends StatefulWidget {
  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  BottomBarViewModel _barController = Get.find();

  RxInt pageChange = 0.obs;

  PageController pageController = PageController();
  ArtistProfileViewModel artistProfileViewModel = Get.find();
  ChatViewModel _chatController = Get.find();

  @override
  void initState() {
    super.initState();
    artistProfileViewModel
        .getWithdraws(PreferenceManager.getShopId().toString());
    artistProfileViewModel
        .serviceProviedByShop(PreferenceManager.getShopId().toString());
    _chatController.shopSales();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarViewModel>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            _barController
                .setSelectedRoute(controller.balancePreviousRoute.value);

            return Future.value(false);
          },
          child: Scaffold(
            appBar: customAppBar(
              PreferenceManager.getUserName(),
              leadingOnTap: () {
                _barController
                    .setSelectedRoute(controller.balancePreviousRoute.value);
              },
              action: svgChat(),
            ),
            body: _buildBody(context),
          ),
        );
      },
    );
  }

  SlidingUpPanel _buildBody(BuildContext context) {
    return SlidingUpPanel(
      body: sliderUpPanelBody(title: 'All'),
      panel: panelPart(context),
      minHeight: Get.height * 0.27,
      maxHeight: Get.height * 0.68,
      backdropEnabled: true,
      color: Colors.transparent,
    );
  }

  Container panelPart(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          )),
      child: Column(children: <Widget>[
        SizedBox(
          height: Get.height * 0.02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.height * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    withdrawDialog();
                  },
                  child: svgBalance),
              Obx(() {
                return Column(
                  children: [
                    Text(
                      pageChange.value == 1 ? "Withdrawal" : "Balance",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Get.height * 0.025),
                    ),
                    Text(
                      "History",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Get.height * 0.015),
                    ),
                  ],
                );
              }),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.005,
        ),
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                2,
                (index) => Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Container(
                        height: Get.height * 0.007,
                        width: pageChange.value == index
                            ? Get.width * 0.05
                            : Get.width * 0.02,
                        decoration: BoxDecoration(
                            color: cRoyalBlue,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )),
          );
        }),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Container(
          height: Get.height * 0.055,
          width: Get.width * 0.7,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(
                    0.8, 0.0), // 10% of the width, so there are ten blinds.
                colors: <Color>[
                  Color(0xff3E5AEF),
                  Color(0xff6C0BB9)
                ], // red to yellow
              ),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              Expanded(
                child: Center(
                    child: Text(
                  "Total Balance",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: Get.height * 0.017),
                )),
              ),
              Expanded(child: GetBuilder<ArtistProfileViewModel>(
                builder: (controller) {
                  if (controller.shopBalanceApiResponse.status ==
                      Status.COMPLETE) {
                    ShopBalanceResponse response =
                        controller.shopBalanceApiResponse.data;
                    return Center(
                      child: Text(
                        "\$${response.data.balance ?? "0"}",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: Get.height * 0.017),
                      ),
                    );
                  }

                  return Center(
                    child: Text(
                      "\$0",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: Get.height * 0.017),
                    ),
                  );
                },
              )),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Expanded(
          child: PageView(
            onPageChanged: (val) {
              pageChange.value = val;
            },
            controller: pageController,
            children: [
              balancePage(),
              withdrawalPage(context),
            ],
          ),
        ),
      ]),
    );
  }
}
