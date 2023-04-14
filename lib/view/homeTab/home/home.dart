import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/get_location.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/get_category_viewModel.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/filter_box.dart';
import 'widgets/story_list.dart';
import 'widgets/user_posts.dart';

class HomeScreen extends StatefulWidget {
  final String role;

  const HomeScreen({Key key, this.role = 'Artist'}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  HomeTabViewModel homeTabViewModel = Get.find();
  NewStoryViewModel _storyViewModel = Get.find();
  RxDouble sliderValue = 0.0.obs;
  GetCategoryViewModel getCategoryViewModel = Get.find();
  BottomBarViewModel _barController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllApi();
  }

  void getAllApi() {
    homeTabViewModel.locationAndService();
    print('latlong:${GetLocation.latitude} ${GetLocation.longitude}');
    _storyViewModel.getArtistAllStory(
        long: GetLocation.longitude.toString(),
        lat: GetLocation.latitude.toString());
    homeTabViewModel.getHomeFeed(
        long: GetLocation.longitude.toString(),
        lat: GetLocation.latitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: cDarkBlue,
        child: GetLocation.longitude == 0.0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  customAppBar('Home'),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: searchTextfield(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        storyList(
                          widget.role,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(bottom: 10),
                            physics: NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Obx(() => filterBox(sliderValue.value,
                                        role: widget.role,
                                        lati: GetLocation.latitude,
                                        serviceVisible: false,
                                        longi: GetLocation.longitude,
                                        onSliderDrag: (handlerIndex, lowerValue,
                                            upperValue) {
                                      sliderValue.value = lowerValue;
                                    })),
                                SizedBox(
                                  height: 10,
                                ),
                                posts(widget.role)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Padding recentPostText() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Text(
        'Recent posts',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget searchTextfield() {
    return GestureDetector(
      onTap: () {
        BottomBarViewModel _barController = Get.find();
        _barController.setSelectedRoute("SearchScreen");
      },
      child: Container(
        height: Get.height * 0.05,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Color(0xff999B9E),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Search..",
                style: TextStyle(
                    color: Color(0xff999B9E), fontSize: Get.height * 0.02),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
