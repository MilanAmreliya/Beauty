import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/text_style.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(String title,
    {Function leadingOnTap,Widget action}) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    iconTheme: IconThemeData(color: cRoyalBlue),
    leading: leadingOnTap == null
        ? SizedBox()
        : InkResponse(
            onTap: leadingOnTap, child: Icon(Icons.arrow_back_ios_outlined)),
    title: Text(
      title,
      style: appBarTitleStyle(),
    ),
    actions: [Padding(
      padding: const EdgeInsets.only(right: 15),
      child: action??SizedBox(),
    )],
  );
}
