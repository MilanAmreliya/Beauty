import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/small_profile_header.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/dialogs/appoinment_request_confirm_dialog.dart';
import 'package:beuty_app/dialogs/booked_appointment_dialog.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_appointment_booked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_appointment_history_repponse_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_appointment_pending_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/commanScreen/chats/chat_screen.dart';
import 'package:beuty_app/view/profileTab/appointment/widgets/aapointment_date.dart';
import 'package:beuty_app/viewModel/appointment_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  List timeList = ["11 AM", "1 PM", "3 PM", "4 PM", "11 AM "];
  AppointmentViewModel _appointmentController = Get.find();
  BottomBarViewModel _barController = Get.find();
  ArtistProfileViewModel artistProfileViewModel = Get.find();

  RxInt _selectedPageIndex = 0.obs;

  @override
  void initState() {
    _appointmentController.getBookedAppointment();
    _appointmentController.getHistoryAppointment();
    _appointmentController.artistPendingAppointment();
    artistProfileViewModel.getProfileDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('HomeScreen');
        _barController.setSelectedIndex(0);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: customAppBar(
          "Booking Page",
          leadingOnTap: () {
            _barController.setSelectedRoute('HomeScreen');
            _barController.setSelectedIndex(0);
          },
          action: svgChat(),
        ),
        body: SafeArea(
          child: Container(
            // height: Get.height / 1.24 - .6,
            // width: Get.width,
            //color: Colors.deepOrange,
            color: Color(0XFF03000F),
            child: Column(
              children: [
                GetBuilder<ArtistProfileViewModel>(
                  builder: (controller) {
                    if (controller.artistProfileApiResponse.status ==
                        Status.COMPLETE) {
                      ArtistProfileDetailResponse response =
                          controller.artistProfileApiResponse.data;
                      return smallProfileHeader(
                          name: response.data.username,
                          subName: response.data.role,
                          imageUrl: response.data.image);
                    }
                    if (controller.artistProfileApiResponse.status ==
                        Status.ERROR) {
                      return Center(
                        child: Text('Server Error'),
                      );
                    }
                    return circularIndicator();
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Container(
                    // width: Get.width,
                    // height: Get.height / 1.4 - 29,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Stack(
                      children: [
                        PageView(
                          children: [
                            RequestedPage(),
                            SecondPage(),
                            thirdPage(),
                          ],
                          onPageChanged: (int index) {
                            _selectedPageIndex.value = index;
                          },
                        ),
                        Obx(() => pageIndicator(
                              selectedIndex: _selectedPageIndex.value,
                            )),
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

class pageIndicator extends StatelessWidget {
  final int selectedIndex;

  const pageIndicator({Key key, this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: Get.width / 2.6,
      top: Get.height / 16,
      child: GetBuilder<AppointmentViewModel>(
        builder: (controller) {
          return Row(
            children: List.generate(
                3,
                (index) => AnimatedContainer(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                      height: 10,
                      width: (index == selectedIndex) ? 30 : 10,
                      decoration: BoxDecoration(
                        color: cRoyalBlue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      duration: Duration(milliseconds: 300),
                    )),
          );
        },
      ),
    );
  }
}

class thirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: Container(
        //color: Colors.red,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            titleForAppointmentScreen(currentAppointmentStatus: "Booked"),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GetBuilder<AppointmentViewModel>(
                builder: (controller) {
                  if (controller.bookedAppointmentApiResponse.status ==
                      Status.LOADING) {
                    return Center(child: circularIndicator());
                  }
                  if (controller.bookedAppointmentApiResponse.status ==
                      Status.ERROR) {
                    return Center(child: Text("Server Error"));
                  }
                  ArtistAppointmentBookedResponse response =
                      controller.bookedAppointmentApiResponse.data;

                  if (response.data.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text('No any appointment book'),
                    );
                  }
                  return Container(
                    width: Get.width,
                    child: ListView.builder(
                      itemCount: response.data.length,
                      itemBuilder: (context, index) {
                        return dataBox(
                            artistId:
                                PreferenceManager.getCustomerRole() == "Model"
                                    ? (response.data[index].artistId.toString() ?? '')
                                    : (response.data[index].modelId.toString() ?? ''),
                            modelName: response.data[index].modelName ?? '',
                            title: response.data[index].serviceName ?? '',
                            image: response.data[index].image ?? '',
                            subTitle:
                                response.data[index].serviceCategory ?? '',
                            price: '\$' +
                                (response.data[index].ammount?.toString() ??
                                    '0'),
                            date: response.data[index].startTime,
                            onPressed: () {
                              bookedAppointmentDialog(response.data[index]);
                            });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: Container(
        //color: Colors.red,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            titleForAppointmentScreen(currentAppointmentStatus: "History"),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GetBuilder<AppointmentViewModel>(
                builder: (controller) {
                  if (controller.historyAppointmentApiResponse.status ==
                      Status.LOADING) {
                    return Center(child: circularIndicator());
                  }
                  if (controller.historyAppointmentApiResponse.status ==
                      Status.ERROR) {
                    return Center(child: Text("Server Error"));
                  }

                  ArtistAppointmentHistoryResponse response =
                      controller.historyAppointmentApiResponse.data;
                  if (response.data.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text('No appointment history available'),
                    );
                  }
                  return Container(
                    width: Get.width,
                    //color: Colors.blueAccent,
                    child: ListView.builder(
                      itemCount: response.data.length,
                      itemBuilder: (context, index) {
                        return dataBox(
                          modelName: response.data[index].modelName??'N/A',
                            artistId:
                                response.data[index].artistId.toString() ?? '',
                            title: response.data[index].serviceName ?? '',
                            subTitle:
                                response.data[index].serviceCategory ?? '',
                            price: '\$' +
                                    response.data[index].ammount?.toString() ??
                                '',
                            date: response.data[index].startTime,
                            onPressed: () {});
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RequestedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: Container(
        //color: Colors.red,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            titleForAppointmentScreen(currentAppointmentStatus: "Requested"),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GetBuilder<AppointmentViewModel>(
                builder: (controller) {
                  if (controller.artistPendingAppointmentApiResponse.status ==
                      Status.LOADING) {
                    return Center(child: circularIndicator());
                  }
                  if (controller.artistPendingAppointmentApiResponse.status ==
                      Status.ERROR) {
                    return Center(child: Text("Server Error"));
                  }

                  ArtistAppointmentPendingResponse response =
                      controller.artistPendingAppointmentApiResponse.data;
                  if (response.data.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text('No any appointment requested'),
                    );
                  }
                  return Container(
                    width: Get.width,
                    child: ListView.builder(
                      itemCount: response.data.length,
                      itemBuilder: (context, index) {
                        return dataBox(modelName: response.data[index].modelName??'N/A',
                            artistId:
                                response.data[index].artistId.toString() ?? '',
                            title: response.data[index].serviceName ?? '',
                            subTitle:
                                response.data[index].serviceCategory ?? '',
                            price: '\$' +
                                (response.data[index].ammount?.toString() ??
                                    '0'),
                            date: response.data[index].startTime,
                            onPressed: () {
                              appointmentRequestConfirmDialog(
                                  response.data[index].id.toString());
                            });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget dataBox(
    {String title,
    String image,
    String artistId,
    String subTitle,
    String price,
    DateTime date,
    Function onPressed,
    String modelName}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
        width: Get.width,
        //color: Colors.blueAccent,
        child: MaterialButton(
          onPressed: onPressed,
          child: Container(
            height: Get.height * 0.11,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    spreadRadius: 1,
                    blurRadius: 1),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 10,
                ),
                image == null || image == ''
                    ? imageNotFound()
                    : ClipOval(
                        child: commonProfileOctoImage(
                          image: image,
                          height: Get.height * 0.07,
                          width: Get.height * 0.07,
                        ),
                      ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: Get.height * 0.018,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Text(
                        subTitle,
                        style: TextStyle(
                            fontSize: Get.height * 0.018,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Color(0xffBBBDC1)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  price,
                  style: TextStyle(
                      fontSize: Get.height * 0.016,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                SizedBox(
                  width: Get.width / 15,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${DateFormat('dd.MM.yy').format(date)}",
                          style: TextStyle(
                              fontSize: Get.height * 0.016,
                              color: Color(0xff080A0C)),
                        ),
                        Text(
                          "${DateFormat.jm().format(date)}",
                          style: TextStyle(
                              fontSize: Get.height * 0.016,
                              color: Color(0xff080A0C)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(ChatScreen(
                      userImg: image,
                      userName: modelName,
                      receiverId: artistId.toString(),
                    ));
                  },
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/svg/chat.svg",
                      color: cRoyalBlue,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            // color: Colors.blue,
          ),
        )),
  );

}
/*  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Slidable(
      actionExtentRatio: 0.22,
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        GestureDetector(
          onTap: () {
            Get.to(ChatScreen(
              userImg: image,
              userName: modelName,
              receiverId: artistId.toString(),
            ));
          },
          child: Container(
              height: Get.height * 0.11,
              // width: Get.width * 0.07,
              decoration: BoxDecoration(
                  color: cRoyalBlue, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: SvgPicture.asset(
                  "assets/svg/chat.svg",
                  color: Colors.white,
                ),
              )),
        )
      ],
      child: Container(
          width: Get.width,
          //color: Colors.blueAccent,
          child: MaterialButton(
            onPressed: onPressed,
            child: Container(
              height: Get.height * 0.11,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      spreadRadius: 1,
                      blurRadius: 1),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 10,),

                  image == null || image == ''
                      ? imageNotFound()
                      : ClipOval(
                          child: commonOctoImage(
                            image: image,
                            height: Get.height * 0.07,
                            width: Get.height * 0.07,
                          ),
                        ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: Get.height * 0.018,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          subTitle,
                          style: TextStyle(
                              fontSize: Get.height * 0.018,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Color(0xffBBBDC1)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 20,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        price,
                        style: TextStyle(
                            fontSize: Get.height * 0.016,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 15,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${DateFormat('dd.MM.yy').format(date)}",
                            style: TextStyle(
                                fontSize: Get.height * 0.016,
                                color: Color(0xff080A0C)),
                          ),
                          Text(
                            "${DateFormat.jm().format(date)}",
                            style: TextStyle(
                                fontSize: Get.height * 0.016,
                                color: Color(0xff080A0C)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // color: Colors.blue,
            ),
          )),
    ),
  );*/