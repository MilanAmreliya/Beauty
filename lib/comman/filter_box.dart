import 'dart:developer';

import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/model/apiModel/requestModel/find_shop_by_filter_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/find_shop_by_filter_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/home_screen_feed_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/package/slider_package.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
Container filterBox(double value,
    {Function onSliderDrag,
      String role,
      bool serviceVisible = true,
      dynamic lati,
      dynamic longi}) {
  return Container(
    height: serviceVisible ? 190 : 160,
    width: Get.width,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rowText('Select km', 'Location', 'sortVertical'),
        SizedBox(
          height: 20,
        ),
        positionSlider(value, onSliderDrag: onSliderDrag),
        SizedBox(
          height: serviceVisible ? 20 : 10,
        ),
        serviceVisible
            ? rowText('Filtered', 'Services', 'sortHorizantal')
            : SizedBox(),
        SizedBox(
          height: 20,
        ),
        bottomHeader(
            value: value,
            serviceVisible: serviceVisible,
            longi: longi,
            lati: lati,
            role: role)
      ],
    ),
  );
}

Widget bottomHeader({double value,
  bool serviceVisible,
  dynamic lati,
  dynamic longi,
  String role}) {
  return GetBuilder<HomeTabViewModel>(
    builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         /* Text(
              "${controller.currentLocation.value == ""
                  ? "Location"
                  : '${controller.currentLocation.value}'}"),*/
          Text('${value == 0.0 ? 'KM' : '$value KM'}'),
          serviceVisible
              ? Text(
              "${controller.services.value == "" ? "Service" : '${controller
                  .services.value}'}")
              : SizedBox(),
          GestureDetector(
            onTap: () async {
              await onApplyTap(controller, value, lati, longi, role);

            },
            child: Container(
              height: 25,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(colors: [
                    Color(0xff3E5AEF),
                    Color(0xff6C0BB9),
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
              child: Center(
                  child: Text(
                    'Apply',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  )),
            ),
          )
        ],
      );
    },
  );
}





Future<void> onApplyTap(HomeTabViewModel controller, double value, dynamic lati,
    dynamic longi, String role) async {
  if (value == 0.0) {
    CommanWidget.snackBar(
      message: "Please Select km ",
    );
    return;
  }

  log('lat:$lati');
  log('longi:$longi');
  FindShopByFilterReqModel findShopByFilterReqModel =
  FindShopByFilterReqModel();

  findShopByFilterReqModel.distance = value.toString();
  findShopByFilterReqModel.service = controller.services.value;
  findShopByFilterReqModel.place = controller.currentLocation.value;
  findShopByFilterReqModel.lati = lati.toString();
  findShopByFilterReqModel.longi = longi.toString();
  findShopByFilterReqModel.userId=PreferenceManager.getArtistId().toString();
  await controller.findShopByFilter(findShopByFilterReqModel);
  if (controller.findShopByFilterApiResponse.status == Status.COMPLETE) {
    HomeScreenFeedResponse response =
        controller.findShopByFilterApiResponse.data;
    print('response:${response.success}');
    if (response.success) {
      BottomBarViewModel _barController = Get.find();
      controller.setRole(role);
      _barController.setSelectedRoute("FilterShopDataScreen");
    } else {
      CommanWidget.snackBar(message: 'Server Error');
    }
  } else {
    CommanWidget.snackBar(message: 'Server Error');
  }
}

Widget positionSlider(double value, {Function onSliderDrag}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Stack(
      overflow: Overflow.visible,
      children: [
        CustomFlutterSlider(
          values: [value],
          max: 30,
          min: 0,
          handlerHeight: 15,
          handlerWidth: 15,
          trackBar: FlutterSliderTrackBar(
              activeTrackBar: BoxDecoration(
                color: Color(0xffC1C4F5),
              )),
          handler: FlutterSliderHandler(
            decoration:
            BoxDecoration(color: Color(0xff424BE1), shape: BoxShape.circle),
            child: Text(""),
          ),
          tooltip: FlutterSliderTooltip(
              boxStyle: FlutterSliderTooltipBox(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  )),
              alwaysShowTooltip: true,
              // textStyle: ,
              rightSuffix: Text(
                " KM",
                style: TextStyle(fontSize: 40, color: Colors.black),
              ),
              textStyle: TextStyle(fontSize: 40, color: Colors.black),
              direction: FlutterSliderTooltipDirection.top),
          onDragging: onSliderDrag,
        ),
        value < 4
            ? SizedBox()
            : Positioned(
          bottom: -10,
          left: 0,
          child: Text('0 KM', style: TextStyle(fontSize: 10)),
        ),
        value > 26
            ? SizedBox()
            : Positioned(
          bottom: -10,
          right: 0,
          child: Text('30 KM', style: TextStyle(fontSize: 10)),
        ),
      ],
    ),
  );
}

Row rowText(String title, String sub, String icon) {
  return Row(
    children: [
      Text(
        title,
        style:
        TextStyle(fontWeight: FontWeight.w600, fontSize: Get.height * 0.02),
      ),
      /*Spacer(),
      Text(
        sub,
      ),
      SizedBox(
        width: 10,
      ),
      InkWell(
        onTap: () {
          if (title == "Filtered") {
            return selectedServiceDialog();
          } else {
            return selectLocationDialog();
          }
        },
        child: Image.asset(
          "assets/image/$icon.png",
          height: 15,
          width: 15,
        ),
      )*/
    ],
  );
}
