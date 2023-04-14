import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/show_ratting_bar.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_appointment_booked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/cancel_aapointment_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/viewModel/appointment_viewmodel.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

CommentAndLikePostViewModel likePostViewModel = Get.find();
enum KeyPointer { img }

Future<void> bookedAppointmentDialog(BookedDatum bookedDatum) {
  bool isLoading = false;
  return Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.01, horizontal: Get.width * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              topProfileView(bookedDatum),
              topImageView(bookedDatum),
              SizedBox(
                height: Get.height * 0.01,
              ),
              specificationView(bookedDatum),
              SizedBox(
                height: Get.height * 0.03,
              ),
              bottomRow(bookedDatum, isLoading, onTap: (bool value) {
                setState(() {
                  isLoading = value;
                });
              })
            ],
          ),
        );
      },
    ),
  ));
}

Row bottomRow(BookedDatum bookedDatum, bool isLoading, {Function onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      isLoading
          ? circularIndicator()
          : customBtn(
              height: Get.height * 0.04,
              width: Get.width * 0.5,
              title: 'Cancel Appointment',
              radius: 110,
              onTap: () async {
                AppointmentViewModel viewModel = Get.find();
                onTap(true);
                await viewModel.cancelAppointment(bookedDatum.id.toString());
                if (viewModel.cancelAppointmentApiResponse.status ==
                    Status.COMPLETE) {
                  CancelAppointmentResponse response =
                      viewModel.cancelAppointmentApiResponse.data;
                  if (response.message == "Appointment cancelled") {
                    CommanWidget.snackBar(message: response.message);
                    await viewModel.getBookedAppointment();
                    Get.back();
                  } else {
                    CommanWidget.snackBar(
                        message: 'Appointment not cancel plz try again');
                  }
                } else {
                  CommanWidget.snackBar(message: 'Server Error');
                }
                onTap(false);
              }),
      /*Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [
                Color(0xFF3E5AEF),
                Color(0xFF6C0BB9),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        height: Get.height * 0.09,
        width: Get.width * 0.09,
        child: Center(
          child: Image.asset(
            'assets/image/chaticon.png',
            width: Get.height * 0.02,
            height: Get.height * 0.02,
          ),
        ),
      ),*/
    ],
  );
}

Padding specificationView(BookedDatum bookedDatum) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Specification',
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: Get.height * 0.02,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Text(
          bookedDatum.description ?? 'N/A',
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.grey,
              fontSize: Get.height * 0.014,
              fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}

Padding centerView(BookedDatum bookedDatum) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: Get.height * 0.01, horizontal: Get.width * 0.03),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bookedDatum.serviceName ?? '',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Poppins",
              fontSize: Get.height * 0.016),
        ),
        showRattingBar(),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Row(
          children: [
            Container(
              width: Get.width * 0.2,
              height: Get.height * 0.03,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black, width: 1)),
              child: Center(
                child: Text(
                  '\$${bookedDatum.price ?? ''}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    fontSize: Get.height * 0.02,
                  ),
                ),
              ),
            ),
            Spacer(),
            Column(
              children: [
                Text(
                  bookedDatum.date == null
                      ? ''
                      : "${DateFormat('dd.MM.yy').format(bookedDatum.date)}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      fontSize: Get.height * 0.014),
                ),
                Text(
                  bookedDatum.date == null
                      ? ''
                      : "${DateFormat.jm().format(bookedDatum.date)}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      fontSize: Get.height * 0.014),
                ),
              ],
            )
          ],
        ),
      ],
    ),
  );
}

Widget topImageView(BookedDatum bookedDatum) {
  return Padding(
    padding: EdgeInsets.only(top: Get.height * 0.01),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: bookedDatum.image == null || bookedDatum.image == ''
          ? imageNotFound()
          : Container(
              color: Colors.grey.withOpacity(0.3),
              height: Get.height * 0.35,
              width: Get.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: commonOctoImage(
                    image: bookedDatum.image, circleShape: false, fit: true),
              ),
            ),
    ),
  );
}

Padding topProfileView(BookedDatum bookedDatum) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
    child: Row(
      children: [
        Container(
          height: Get.height * 0.05,
          child: Stack(
            children: [
              bookedDatum.image == null || bookedDatum.image == ''
                  ? imageNotFound()
                  : ClipOval(
                      child: commonProfileOctoImage(
                        image: bookedDatum.image,
                        height: Get.height * 0.07,
                        width: Get.height * 0.07,
                      ),
                    ),
         /*     Positioned(
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      color: Color(0xff2DB80A),
                      shape: BoxShape.circle),
                  width: Get.height * 0.015,
                  height: Get.height * 0.015,
                ),
              )*/
            ],
          ),
        ),
        SizedBox(
          width: Get.width * 0.03,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookedDatum.serviceName ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Get.height * 0.02,
                  fontFamily: "Poppins"),
            ),
            Text(
              bookedDatum.serviceCategory ?? '',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: Get.height * 0.016,
                  fontFamily: "Poppins"),
            ),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff424BE1), width: 1)),
            child: Icon(
              Icons.clear,
              color: Color(0xff424BE1),
            ),
          ),
        ),
      ],
    ),
  );
}
