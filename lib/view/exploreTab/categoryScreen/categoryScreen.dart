import 'dart:developer';

import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/filter_box.dart';
import 'package:beuty_app/comman/hair_items_list.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/get_category_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'widgets/category_list.dart';

class CategoryScreen extends StatefulWidget {
  final String role;

  const CategoryScreen({Key key, this.role}) : super(key: key);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  GetCategoryViewModel getCategoryViewModel = Get.find();
  RxDouble sliderValue = 0.0.obs;

  dynamic kLatitude = 0.0;
  dynamic kLongitude = 0.0;
  BottomBarViewModel _barController = Get.find();

  @override
  void initState() {
    super.initState();
    geoLocator();
  }

  Future geoLocator() async {
    var getLocator = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      kLatitude = getLocator.latitude;
      kLongitude = getLocator.longitude;
    });

    log("LAT${kLatitude} LONG ${kLongitude}");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('ExploreScreen');

        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: customAppBar('Category', action: svgChat(), leadingOnTap: () {
            _barController.setSelectedRoute('ExploreScreen');
          }),
          body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          topHeader(onTap: (String value) {
            getCategoryViewModel.onChnage(value);
          }),
          SizedBox(
            height: 20,
          ),
          Obx(() => filterBox(sliderValue.value,
                  role: widget.role,
                  lati: kLatitude,
                  longi: kLongitude,
                  serviceVisible: true,
                  onSliderDrag: (handlerIndex, lowerValue, upperValue) {
                sliderValue.value = lowerValue;
              })),
          SizedBox(
            height: 20,
          ),
          hairItemsList(),
        ],
      ),
    );
  }
}
