import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/responseModel/toplocationandservice_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../comman/custom_btn.dart';

selectLocationDialog() {
  String searchedStr, selectedString;
  List<Location> locationList = [];
  List<Location> searchedList = [];

  return Get.dialog(
    Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02, horizontal: Get.height * 0.02),
        child: StatefulBuilder(
          builder: (context, dialogSetState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Select Location",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: cLightGrey)),
                    padding: EdgeInsets.only(left: 10),
                    child: Center(
                      child: TextField(
                        onChanged: (value) {
                          searchedStr = value;
                          if (value.isEmpty) {
                            dialogSetState(() {});
                            return;
                          }
                          HomeTabViewModel controller = Get.find();
                          LocationAndServiceResponse response =
                              controller.locationAndServiceApiResponse.data;

                          if (response.data.locations.isEmpty) {
                            return;
                          } else {
                            searchedList.clear();
                            response.data.locations.forEach((element) {
                              if (element.placeName
                                  .toLowerCase()
                                  .contains(searchedStr.toLowerCase())) {
                                searchedList.add(element);
                              }
                            });
                            dialogSetState(() {});
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search..',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                print(searchedStr);
                              },
                              child: Icon(
                                Icons.search,
                                color: Color(0xff999B9E),
                              ),
                            ),
                            hintStyle: TextStyle(color: cDarkGrey)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  SizedBox(
                      height: Get.height * 0.3,
                      child: GetBuilder<HomeTabViewModel>(
                        builder: (controller) {
                          if (controller.locationAndServiceApiResponse.status !=
                              Status.COMPLETE) {
                            return Center(child: circularIndicator());
                          }
                          if (controller.locationAndServiceApiResponse.status ==
                              Status.ERROR) {
                            return Center(child: Text("Server Error"));
                          }

                          LocationAndServiceResponse response =
                              controller.locationAndServiceApiResponse.data;

                          if (response.data.locations.isEmpty) {
                            return Text("No Location Found");
                          }
                          if (searchedStr == null || searchedStr == "") {
                            locationList = response.data.locations;
                          } else {
                            locationList = searchedList;
                          }
                          return GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: 1 / 0.45,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            children: locationList
                                .map((e) => Material(
                                      color: Colors.transparent,
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: selectedString == e.placeName
                                                ? cRoyalBlue
                                                : Colors.transparent,
                                            border: Border.all(
                                                color:
                                                    selectedString == e.placeName
                                                        ? cRoyalBlue
                                                        : cLightGrey)),
                                        child: InkWell(
                                          onTap: () {
                                            dialogSetState(() {
                                              selectedString = e.placeName;
                                            });
                                            HomeTabViewModel homeTabViewModel =
                                                Get.find();
                                            homeTabViewModel.setCurrentLocation(
                                                selectedString);
                                          },
                                          child: Center(
                                              child: Text(
                                            e.placeName,
                                            style: TextStyle(
                                                color:
                                                    selectedString == e.placeName
                                                        ? cWhite
                                                        : cLightGrey),
                                            textAlign: TextAlign.center,
                                          )),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        },
                      )),

                  // SizedBox(
                  //   height: Get.height * 0.01,
                  // ),
                  Align(
                      alignment: Alignment.center,
                      child: customBtn(
                          title: 'CONFIRM',
                          radius: 30,
                          onTap: () {
                            Get.back();
                          })),
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}

selectedServiceDialog() {
  String searchedStr, selectedString;
  List<ServiceType> serviceList = [];
  List<ServiceType> searchedList = [];
  return Get.dialog(
    Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02, horizontal: Get.height * 0.02),
        child: StatefulBuilder(
          builder: (context, dialogSetState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Service",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: cLightGrey)),
                  padding: EdgeInsets.only(left: 10),
                  child: Center(
                    child: TextField(
                      onChanged: (value) {
                        searchedStr = value;
                        if (value.isEmpty) {
                          dialogSetState(() {});
                          return;
                        }
                        HomeTabViewModel controller = Get.find();
                        LocationAndServiceResponse response =
                            controller.locationAndServiceApiResponse.data;
                        if (response.data.serviceType.isEmpty) {
                          return;
                        } else {
                          searchedList.clear();
                          response.data.serviceType.forEach((element) {
                            if (element.serviceCategoryName
                                .toLowerCase()
                                .contains(searchedStr.toLowerCase())) {
                              searchedList.add(element);
                            }
                          });
                          dialogSetState(() {});
                        }
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search..',
                          suffixIcon: Icon(
                            Icons.search,
                            color: Color(0xff999B9E),
                          ),
                          hintStyle: TextStyle(color: cDarkGrey)),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(
                    height: Get.height * 0.3,
                    child: GetBuilder<HomeTabViewModel>(
                      builder: (controller) {
                        if (controller.locationAndServiceApiResponse.status ==
                            Status.LOADING) {
                          return Center(child: circularIndicator());
                        }
                        if (controller.locationAndServiceApiResponse.status ==
                            Status.ERROR) {
                          return Center(child: Text("Server Error"));
                        }
                        LocationAndServiceResponse response =
                            controller.locationAndServiceApiResponse.data;
                        if (response.data.locations.isEmpty) {
                          return Text("No Category Found");
                        }
                        if (searchedStr == null || searchedStr == "") {
                          serviceList = response.data.serviceType;
                        } else {
                          serviceList = searchedList;
                        }
                        return GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: 1 / 0.45,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          children: serviceList
                              .map((e) => Material(
                                    color: Colors.transparent,
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: selectedString ==
                                                  e.serviceCategoryName
                                              ? cRoyalBlue
                                              : Colors.transparent,
                                          border: Border.all(
                                              color: selectedString ==
                                                      e.serviceCategoryName
                                                  ? cRoyalBlue
                                                  : cLightGrey)),
                                      child: InkWell(
                                        onTap: () {
                                          dialogSetState(() {
                                            selectedString =
                                                e.serviceCategoryName;
                                          });
                                          HomeTabViewModel homeTabViewModel =
                                              Get.find();
                                          homeTabViewModel
                                              .setServices(selectedString);
                                          print(homeTabViewModel.services);
                                        },
                                        child: Center(
                                            child: Text(
                                          e.serviceCategoryName,
                                          style: TextStyle(
                                              color: selectedString ==
                                                      e.serviceCategoryName
                                                  ? cWhite
                                                  : cLightGrey),
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        );
                      },
                    )),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Align(
                    alignment: Alignment.center,
                    child: customBtn(
                        title: 'CONFIRM',
                        radius: 30,
                        onTap: () {
                          Get.back();
                        })),
              ],
            );
          },
        ),
      ),
    ),
  );
}
