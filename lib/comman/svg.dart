import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

final String path = "assets/svg/";

Widget svgChat() {
  return InkWell(
      onTap: () {
        BottomBarViewModel _barController = Get.find();
        _barController.setSelectedRoute('UserListChat');
      },
      child: SvgPicture.asset("${path + 'chat.svg'}"));
}

final SvgPicture svgMap = SvgPicture.asset(
  "${path + 'map.svg'}",
  height: 50,
  width: 50,
);
final SvgPicture svgAddPhoto = SvgPicture.asset("${path + 'add_photo.svg'}");
final SvgPicture svgLogo = SvgPicture.asset("${path + 'logo.svg'}");

final SvgPicture svgBalance=SvgPicture.asset(
  "assets/svg/balance.svg",
  height: Get.height * 0.025,
);

final SvgPicture svgMenu=SvgPicture.asset(
  "assets/svg/menu.svg",
  height: Get.height * 0.025,
);