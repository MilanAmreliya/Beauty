import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/show_ratting_bar.dart';
import 'package:beuty_app/model/apiModel/responseModel/delete_service_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

enum KeyPointer { img }

Future<void> serviceDeleteDialog(BuildContext context,
    {String serviceName,
    String id,
    String price,
    double rate,
    String description,
    String image,
    String date,
    String time}) async {
  return Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.01, horizontal: Get.width * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          topImageView(image),
          SizedBox(
            height: Get.height * 0.01,
          ),
          // topItemImagelist(),
          centerView(serviceName, price, rate, date, time),
          specificationView(description),
          SizedBox(
            height: Get.height * 0.03,
          ),
          bottomRow(id)
        ],
      ),
    ),
  ));
}

Row bottomRow(String id) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      InkWell(
        onTap: () async {
          ArtistProfileViewModel artistProfileViewModel = Get.find();

          await artistProfileViewModel.deleteService(id);
          if (artistProfileViewModel.deleteServiceApiResponse.status ==
              Status.COMPLETE) {
            DeleteServiceResponse response =
                artistProfileViewModel.deleteServiceApiResponse.data;
            if (response.success) {
              CommanWidget.snackBar(
                message: response.message,
              );
              Future.delayed(Duration(seconds: 2), () {
                BottomBarViewModel _barController = Get.find();

                _barController.setSelectedRoute('ArtistUserProfileScreen');
                Get.back();
              });
            }
          } else {
            CommanWidget.snackBar(
              message: "please try again",
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [
                  Color(0xFF6C0BB9),
                  Color(0xFF3E5AEF),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          height: Get.height * 0.04,
          width: Get.width * 0.4,
          child: Center(
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontSize: Get.height * 0.014,
                fontWeight: FontWeight.w700,
                fontFamily: "Manrope",
              ),
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.back();
          BottomBarViewModel _barController = Get.find();
          _barController.setSelectedRoute('EditServiceScreen');
          HomeTabViewModel controller = Get.find();
          controller.setServiceId(id);
          print("id:$id");
        },
        child: Container(
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
            child: SvgPicture.asset(
              'assets/svg/edit.svg',
              width: Get.height * 0.02,
              height: Get.height * 0.02,
            ),
          ),
        ),
      ),
    ],
  );
}

Padding specificationView(String description) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          description ?? "",
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

Padding centerView(
  String serviceName,
  String price,
  double rate,
  String date,
  String time,
) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: Get.height * 0.01, horizontal: Get.width * 0.03),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          serviceName ?? "",
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
                  '\$${price ?? ""}',
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      fontSize: Get.height * 0.014),
                ),
                Text(
                  time ?? "",
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

Widget topImageView(String image) {
  return Stack(
    children: [
      image == null || image == ''
          ? imageNotLoadRectangle()
          : ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.grey.withOpacity(0.3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: commonOctoImage(
                    image: image,
                    width: Get.width,
                    height: Get.height * 0.225,
                    circleShape: false,
                  ),
                ),
              ),
            ),
      Positioned(
        top: Get.height * 0.01,
        right: Get.width * 0.02,
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            radius: Get.height * 0.016,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.clear,
              color: Color(0xff424BE1),
            ),
          ),
        ),
      )
    ],
  );
}
