import 'dart:developer';
import 'dart:ui';

import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/requestModel/promoted_shop_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_shopid_reponce.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/payment/payment_home.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdsScreen extends StatefulWidget {
  @override
  _AdsScreenState createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  ArtistProfileViewModel artistProfileViewModel = Get.find();
  var isPromotionShop;
  DateTime dateTime;
  bool isPromoted = false;

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  void apiCall() {
    artistProfileViewModel
        .getShopByCreate(PreferenceManager.getArtistId().toString());
    isPromotionShop = PreferenceManager.getShopPromotion();
    log("IS isPromotionShop $isPromotionShop");

    if (isPromotionShop != null && isPromotionShop != "") {
      dateTime = DateTime.parse(isPromotionShop);

      if (dateTime.difference(DateTime.now()).inDays <= 0) {
        isPromoted = true;
      } else {
        isPromoted = false;
      }
      log("IS PROMOTED $isPromoted");
    } else {
      isPromoted = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        'nextMonth :${DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day)}');
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cThemColor,
        appBar: customAppBar('Ads', leadingOnTap: () {
          Get.back();
        }),
        body: Container(
          height: Get.height / 1.3,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))),
          child: GetBuilder<ArtistProfileViewModel>(
            builder: (controller) {
              if (controller.shopIdApiResponse.status == Status.LOADING) {
                return Center(
                  child: circularIndicator(),
                );
              }
              if (controller.shopIdApiResponse.status == Status.ERROR) {
                return Center(
                  child: Text('Server Error'),
                );
              }
              GetShopId response = controller.shopIdApiResponse.data;
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      response.data.img == null || response.data.img == ''
                          ? Center(child: imageNotFound())
                          : Center(
                              child: Container(
                                height: Get.height * 0.15,
                                width: Get.height * 0.15,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: commonOctoImage(
                                      image: response.data.img,
                                      circleShape: false,
                                      fit: true),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      richText('Shop Name : ', response.data.name),
                      SizedBox(
                        height: 20,
                      ),
                      richText('Shop About : ', response.data.aboutShop),
                      SizedBox(
                        height: 20,
                      ),
                      richText('Shop Address : ', response.data.address),
                      SizedBox(
                        height: 20,
                      ),
                      richText('Subscription Plan : ', "\$10 / month"),
                      Spacer(),
                      isPromoted == false
                          ? Center(
                              child: Text(
                              "-: You shop already promoted :-",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ))
                          : Center(
                              child: customBtn(
                                  title: 'Add Promoted Shop',
                                  onTap: () {
                                    onTap(response.data.id.toString());
                                  }),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  controller.promotedApiResponse.status == Status.LOADING
                      ? loadingIndicator()
                      : SizedBox()
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> onTap(String shopId) async {
    DateTime date = DateTime.now();
    PromotedShopRequestModel requestModel = PromotedShopRequestModel();
    requestModel.shopId = shopId;
    requestModel.startDate = date.toString();
    requestModel.endDate =
        DateTime(date.year, date.month + 1, date.day).toString();
    await artistProfileViewModel.createPromotedShop(requestModel);
    if (artistProfileViewModel.promotedApiResponse.status == Status.COMPLETE) {
      PostSuccessResponse response =
          artistProfileViewModel.promotedApiResponse.data;
      if (response.message == "promotion added") {
        CommanWidget.snackBar(message: response.message);
        Get.to(PaymentScreen(
          amount: "10",
        ));
      } else {
        CommanWidget.snackBar(message: response.message);
      }
    } else {
      CommanWidget.snackBar(message: 'Server Error');
    }
  }

  Text richText(String hint, String value) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: hint, style: TextStyle(fontSize: 18)),
      TextSpan(
          text: value ?? 'N/A',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
    ]));
  }
}
