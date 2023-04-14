import 'package:flutter/material.dart';

appointmentDate({String dateText}) {
  return Row(
    children: [
      Text(
        dateText,
        style: TextStyle(
            color: Color(0xff080A0C),
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins'),
      ),
      Spacer(),
      IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {},
      )
    ],
  );
}
