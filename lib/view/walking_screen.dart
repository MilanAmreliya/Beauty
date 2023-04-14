import 'dart:developer';

import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'authScreen/signup/sign_up_screen.dart';

class WalkingScreen extends StatelessWidget {
  RxInt _selectedPageIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    log("selectedIndex..${_selectedPageIndex.value}");
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [

            PageView(
              children: [
                walkingBody(title: "Thank you for downloading this app.", image: "1"),
                walkingBody(title: "Find Shop nearest to your location.", image: "2"),
                walkingBody(title: "Book an Appointment.", image: "3"),
                walkingBody(title: "Meet schedule be happy.", image: "4"),
              ],
              onPageChanged: (index) {
                _selectedPageIndex.value = index;
              },
            ),
            Obx(() => pageIndicator(
              selectedIndex: _selectedPageIndex.value,
            )),
            Positioned(
              bottom: 10,
              right: 20,
              child: Obx(() => _selectedPageIndex.value == 3
                  ? GestureDetector(
                onTap: () async {
                  await PreferenceManager.setWalkingScreen(true);
                  Get.off(SignUpScreen());
                  // Get.off(SignIn());
                },
                child: Container(
                    alignment: Alignment.center,
                    width: Get.width / 5,
                    height: 40,
                    margin: EdgeInsets.only(bottom: 20, right: 20),
                    decoration: BoxDecoration(
                        color: cRoyalBlue,
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          cRoyalBlue1,
                          cPurple,
                        ])),
                    child: Text(
                      "Go",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    )),
              )
                  : SizedBox()),
            ),

          ],
        ),
      ),
    );
  }

  Widget walkingBody({String title, String image}) {
    log("Current index${_selectedPageIndex.value}");
    final String path = "assets/image/";

    return Container(
      height: Get.height,
      width: Get.width,
      // color: cThemColor,
      child: Column(
        children: [
          Spacer(),

          Expanded(flex: 3,child: SvgPicture.asset('assets/svg/OnBoardImg$image.svg')),
          Spacer(),
          Text("$title"),
          Spacer(),
          Spacer(),

        ],
      ),
    );
  }
}

class pageIndicator extends StatefulWidget {
  final int selectedIndex;

  pageIndicator({Key key, this.selectedIndex}) : super(key: key);

  @override
  _pageIndicatorState createState() => _pageIndicatorState();
}

class _pageIndicatorState extends State<pageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
    left: 0,
        right: 0,
        bottom: Get.height / 16,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,

            children: List.generate(
                4,
                (index) => AnimatedContainer(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: index == widget.selectedIndex?Color(0xff1A1C29):Color(0xff707070),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      duration: Duration(milliseconds: 300),
                    )),
          ),
        ));
  }
}
