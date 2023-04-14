import 'package:flutter/material.dart';

import 'box_decoration.dart';

Material customBtn(
    {Function onTap,
    String title,
    double radius,
    double height,
    double width,
    double fontSize}) {
  return Material(
    color: Colors.transparent,
    child: Ink(
      height: height ?? 40,
      width: width ?? 200,
      decoration: gradientDecoration(radius: radius ?? 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius ?? 10),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: fontSize ?? 15),
          ),
        ),
      ),
    ),
  );
}
