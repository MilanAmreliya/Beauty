import 'package:flutter/material.dart';

Widget userData(String title, String count) {
  return Column(
    children: [
      Text(
        count,
        style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600),
      ),
      Text(title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400)),
    ],
  );
}
