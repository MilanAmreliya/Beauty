import 'dart:developer';

import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/allFavorite/all_favorites.dart';
import 'package:beuty_app/view/authScreen/signup/sign_up_screen.dart';
import 'package:beuty_app/view/profileTab/account/account_screen.dart';
import 'package:beuty_app/view/profileTab/foolowAndInvitefriend/follow_and_invite_friend_screen.dart';
import 'package:beuty_app/view/profileTab/transactionHistory/transaction_history_screen.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'ads_screen.dart';
import 'help_screen.dart';
import 'privacy_policy_screen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key key}) : super(key: key);
  List<Map<String, String>> listMap = [
    // {'icon': 'bell', 'title': 'Notification'},
    {'icon': 'person', 'title': 'Follow and Invite Friends'},
    {'icon': 'help', 'title': 'Transaction History'},
    {'icon': 'lock', 'title': 'Privacy'},
    {'icon': 'favourite', 'title': 'Favourite'},
    {'icon': 'ads', 'title': 'Ads'},
    {'icon': 'help', 'title': 'Help'},
    {'icon': 'about', 'title': 'About'},
    {'icon': 'logout', 'title': 'Logout'},
  ];
  BottomBarViewModel barController = Get.find();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: cThemColor,
      appBar: customAppBar('Settings', leadingOnTap: () {
        Get.back();
      }),
      body: Container(
        height: Get.height / 1.3,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: listMap
                      .map((e) => e['title']=='Ads' && PreferenceManager.getCustomerRole()=='Model'?SizedBox():CommanWidget.profileMenus(
                          title: e['title'],
                          width: width,
                          iconName: e['icon'],
                          onClick: () {
                            log(e['title']);
                            onMenuTap(e['title']);
                          }))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onMenuTap(String title) async {
    log(title);
    switch (title) {
      case 'Notification':
        print("Notification");
        break;
      case 'Follow and Invite Friends':
        print("Follow and Invite Friends");
        Get.to(FollowAndInviteFriendScreen());
        break;
      case 'Transaction History':
        print("TransactionHistoryScreen");
        Get.to(TransactionHistoryScreen());
        break;
      case 'Privacy':
        print("Privacy");

        Get.to(PrivacyPolicyScreen());
        break;
      case 'Security':
        print("Security");
        break;
      case 'Favourite':
        Get.to(AllFavoritesScreen());
        break;
      case 'Ads':
        Get.to(AdsScreen());
        break;
      case 'Account':
        print("Account");
        Get.to(AccountScreen());
        break;
      case 'Help':
        print("Help");
        Get.to(HelpScreen());
        break;
      case 'About':
        print("About");
        break;
      case 'Favourite':
        print("favourite");

        break;
      case 'Logout':
        await PreferenceManager.clearData();

        Get.offAll(SignUpScreen());
        break;
    }
  }
}
