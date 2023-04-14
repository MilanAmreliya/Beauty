import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/profileTab/balance/widgets/slider_up_panel_body.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'widgets/hair_cut_item_list.dart';

class HairCut extends StatelessWidget {
  BottomBarViewModel _barController = Get.find();

  RxInt pageChange = 0.obs;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('Balance');

        return Future.value(false);
      },
      child: Scaffold(
        appBar: customAppBar(
          PreferenceManager.getUserName(),
          leadingOnTap: () {
            _barController.setSelectedRoute('Balance');
          },
          action: svgChat(),
        ),
        body: _buildBody(),
      ),
    );
  }

  SlidingUpPanel _buildBody() {
    return SlidingUpPanel(
      body: sliderUpPanelBody(title: 'Hair Cut'),
      panel: panelPart(),
      minHeight: Get.height * 0.27,
      maxHeight: Get.height * 0.68,
      backdropEnabled: true,
      color: Colors.transparent,
    );
  }

  Container panelPart() {
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
          Expanded(child: hairCutItemList()),
        ]));
  }
}
