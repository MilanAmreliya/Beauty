import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/show_ratting_bar.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/model/apiModel/responseModel/search_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  BottomBarViewModel _barController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('HomeScreen');

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: customAppBar(
          'Search',
          leadingOnTap: () {
            _barController.setSelectedRoute('HomeScreen');
          },
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: searchTextfield(searchController),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Expanded(
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
                          height: 20,
                        ),
                        Expanded(
                            child: searchController.text == ""
                                ? Center(child: Text("Searching"))
                                : GetBuilder<HomeTabViewModel>(
                                    builder: (controller) {
                                      SearchResponse response =
                                          controller.searchApiResponse.data;
                                      if (controller.searchApiResponse.status ==
                                          Status.LOADING) {
                                        return Center(
                                            child: circularIndicator());
                                      }
                                      if (controller.searchApiResponse.status ==
                                          Status.ERROR) {
                                        return Center(
                                          child: Text('Server Error'),
                                        );
                                      }
                                      if (response.data.isEmpty) {
                                        return Center(
                                            child: Text("No Artist Found"));
                                      }

                                      return Container(
                                        width: Get.width,
                                        //color: Colors.blueAccent,
                                        child: ListView.builder(
                                          itemCount: response.data.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: MaterialButton(
                                                onPressed: () {
                                                  _barController
                                                      .setSelectedArtistId(
                                                          response
                                                              .data[index].id);
                                                  String role =
                                                      PreferenceManager
                                                          .getCustomerRole();
                                                  String route = role ==
                                                          'Artist'
                                                      ? 'ProfilePostScreen'
                                                      : 'ModelProfilePostScreen';

                                                  _barController
                                                      .setSelectedRoute(route);
                                                },
                                                child: Container(
                                                  height: Get.height * 0.1,
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(.3),
                                                          spreadRadius: 1,
                                                          blurRadius: 1)
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      response.data[index]
                                                                      .profilePic ==
                                                                  null ||
                                                              response
                                                                      .data[
                                                                          index]
                                                                      .profilePic ==
                                                                  ''
                                                          ? imageNotFound()
                                                          : ClipOval(
                                                              child:
                                                                  commonProfileOctoImage(
                                                                image: response
                                                                    .data[index]
                                                                    .profilePic,
                                                                height:
                                                                    Get.height *
                                                                        0.07,
                                                                width:
                                                                    Get.height *
                                                                        0.07,
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            response.data[index]
                                                                .username,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize:
                                                                    Get.height /
                                                                        45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          Text(
                                                            response.data[index]
                                                                .customerRole,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xffBBBDC1)),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: Get.width / 200,
                                                      ),
                                                      showRattingBar(),
                                                      SizedBox(
                                                        width: Get.width / 60,
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
                                  )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container searchTextfield(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(
            width: 15,
          ),
          SizedBox(
            width: Get.width * 0.8,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search..',
                  hintStyle: TextStyle(color: cDarkGrey)),
            ),
          ),
          GestureDetector(
            onTap: () async {
              HomeTabViewModel homeTabViewModel = Get.find();
              setState(() {
                homeTabViewModel.searchModalArtist(controller.text);
              });
            },
            child: Icon(
              Icons.search,
              color: Color(0xff999B9E),
            ),
          ),
        ],
      ),
    );
  }
}

class ListViewPart extends StatelessWidget {
  const ListViewPart({
    Key key,
  }) : super(key: key);

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
                  // IconButton(
                  //     icon: SvgPicture.asset(
                  //       "assets/svg/round_button.svg",
                  //     ),
                  //     onPressed: () {}),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  //color: Colors.blueAccent,
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Container(
                            height: Get.height / 8,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.3),
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/image/cartoon1.png"),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hair cut",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: Get.height / 45,
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
                                  width: Get.width / 200,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height / 17,
                                    ),
                                    Row(
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          Icons.star,
                                          size: Get.height / 40,
                                          color: Color(0xffFFB454),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: Get.width / 60,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$300",
                                      style:
                                          TextStyle(color: Color(0xff080A0C)),
                                    ),
                                    Text(
                                      "08.23",
                                      style:
                                          TextStyle(color: Color(0xff080A0C)),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.more_vert,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
