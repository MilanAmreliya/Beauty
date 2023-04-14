import 'dart:async';
import 'dart:developer';

import 'package:beuty_app/dialogs/location_alert_dialog.dart';
import 'package:beuty_app/dialogs/no_internet_connection_alert_dialog.dart';
import 'package:beuty_app/view/bottomBar/widgets/model_profile_bottom_bar_routrs.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../comman/get_location.dart';
import '../../comman/get_location.dart';
import 'widgets/artist_appointment_bottom_bar_routes.dart';
import 'widgets/artist_explore_bottom_bar_routes.dart';
import 'widgets/artist_home_bottom_bar_routes.dart';
import 'widgets/artist_profile_bottom_bar_routes.dart';
import 'widgets/bottom_navigation_bar.dart';
import 'widgets/model_appointment_bottom_bar_routes.dart';
import 'widgets/model_explore_bottom_bar_routes.dart';
import 'widgets/model_home_bottom_bar_routes.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  ValidationViewModel _validationViewModel = Get.find();
  StreamSubscription<DataConnectionStatus> _connectivitySubscription;
  RxBool isConnection=true.obs;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    Future.delayed(Duration.zero, () async {
      showLocationAlertDialog();
    });
  }

 void showLocationAlertDialog() {
    print('lat:${GetLocation.latitude}');
    if (GetLocation.latitude == 0.0) {
      locationAlertDialog();
    }
  }

  void checkInternetConnection(){
    _connectivitySubscription =
        DataConnectionChecker().onStatusChange.listen((status) async {
          if (status == DataConnectionStatus.disconnected) {
            isConnection.value=false;
          }else{
            isConnection.value=true;
          }
        });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    log("modal value${_validationViewModel.selectRole.value}");
    return Material(
      child: Obx(() => Stack(
        children: [
          Column(
                children: [
                  _validationViewModel.selectRole.value == 'Artist'
                      ? Expanded(
                          child: GetBuilder<BottomBarViewModel>(
                            builder: (controller) {
                              return controller.selectedIndex.value == 0
                                  ? artistHomeBottomBarRoutes(
                                      controller.selectedRoute.value)
                                  : controller.selectedIndex.value == 3
                                      ? artistProfileBottomBarRoutes(
                                          controller.selectedRoute.value)
                                      : controller.selectedIndex.value == 1
                                          ? artistExploreBottomBarRoutes(
                                              controller.selectedRoute.value)
                                          : artistCameraBottomBarRoutes(
                                              controller.selectedRoute.value);
                            },
                          ),
                        )
                      : Expanded(
                          child: GetBuilder<BottomBarViewModel>(
                            builder: (controller) {
                              return controller.selectedIndex.value == 0
                                  ? modelHomeBottomBarRoutes(
                                      controller.selectedRoute.value,
                                    )
                                  : controller.selectedIndex.value == 3
                                      ? modelProfileBottomBarRoutes(
                                          controller.selectedRoute.value)
                                      : controller.selectedIndex.value == 1
                                          ? modelExploreBottomBarRoutes(
                                              controller.selectedRoute.value)
                                          : modelAppointmentBottomBarRoutes(
                                              controller.selectedRoute.value);
                            },
                          ),
                        ),
                  bottomNavigationBar(_validationViewModel)
                ],
              ),
          Obx(()=>!isConnection.value?showConnectionDialog(
            title: 'Connection',
            desc: 'Please check your internet connection'
          )
              :SizedBox())
        ],
      )),
    );
  }
}
