import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/images.dart';
import 'package:beuty_app/comman/popup.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ShopScreen extends StatelessWidget {
  BottomBarViewModel _barController = Get.find();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('CreateShopScreen');
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cDarkBlue,
        appBar: customAppBar('Shop',
            leadingOnTap: () {
              _barController.setSelectedRoute('CreateShopScreen');

            }, action: svgChat(), ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Align(alignment: Alignment.topRight, child: popupBtnMenu()),
                // CommanWidget.userCircleWidget(imagePath: 'assets/image/shop.png'),

                SizedBox(
                  height: 8,
                ),
                Text(
                  'Phanmart',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Banani, Dhaka',
                  style: TextStyle(
                      color: cLightGrey,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 8,
                ),
                iRating,
                SizedBox(
                  height: 8,
                ),

                CommanWidget.sizedBox15(),

                Text(
                    "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400)),

                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40))),
                    child: Column(
                      children: [
                        CommanWidget.sizedBoxD3(),
                        InkWell(
                          onTap: () {
                            _barController.setSelectedRoute('AddServicesScreen');
                            // Get.to(AddServicesScreen());
                          },
                          child: CommanWidget.transparentButton(
                              title: "Add service"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
