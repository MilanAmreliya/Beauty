import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/small_profile_header.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/model_appointment_booked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/model_appointment_history_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/model_appointment_pending_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/commanScreen/chats/chat_screen.dart';
import 'package:beuty_app/view/confirmBooking/confirm_booking.dart';
import 'package:beuty_app/viewModel/appointment_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ModalAppointmentScreen extends StatefulWidget {
  @override
  _ModalAppointmentScreenState createState() => _ModalAppointmentScreenState();
}

class _ModalAppointmentScreenState extends State<ModalAppointmentScreen> {
  List timeList = ["11 AM", "1 PM", "3 PM", "4 PM", "11 AM "];

  RxInt pageChange = 0.obs;
  PageController pageController = PageController();
  BottomBarViewModel _barController = Get.find();
  AppointmentViewModel appointmentViewModel = Get.find();
  ArtistProfileViewModel artistProfileViewModel = Get.find();

  @override
  void initState() {
    super.initState();
    artistProfileViewModel.getProfileDetail(
        artistId: PreferenceManager.getArtistId().toString());
    appointmentViewModel.modelBookedAppointment();
    appointmentViewModel.modelHistoryAppointment();
    appointmentViewModel.modelPendingAppointment();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedIndex(0);
        _barController.setSelectedRoute('HomeScreen');

        return Future.value(false);
      },
      child: Scaffold(
        appBar: customAppBar(
          'Appointment',
          leadingOnTap: () {
            _barController.setSelectedIndex(0);
            _barController.setSelectedRoute('HomeScreen');
          },
          action: svgChat(),
        ),
        body: SafeArea(
          child: Container(
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
                      child: Column(children: <Widget>[
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.height * 0.02),
                          child: Obx(() {
                            return Text(
                              pageChange.value == 0
                                  ? "Book Appointment"
                                  : pageChange.value == 1
                                      ? "Appointment History"
                                      : "Appointment Pending",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: Get.height * 0.025),
                            );
                          }),
                        ),
                        SizedBox(
                          height: Get.height * 0.005,
                        ),
                        Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                3,
                                (index) => Padding(
                                      padding: const EdgeInsets.only(left: 7),
                                      child: Container(
                                        height: Get.height * 0.007,
                                        width: pageChange.value == index
                                            ? Get.width * 0.05
                                            : Get.width * 0.02,
                                        decoration: BoxDecoration(
                                            color: cRoyalBlue,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                    )),
                          );
                        }),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Expanded(
                          child: PageView(
                            onPageChanged: (val) {
                              pageChange.value = val;
                            },
                            controller: pageController,
                            children: [
                              bookAppointmentPage(),
                              appointmentHistoryPage(),
                              pendingAppointmentPage()
                            ],
                          ),
                        ),
                      ])),
                ),
              ],
            ),
            /*  child: SlidingUpPanel(
                body: GetBuilder<ArtistProfileViewModel>(
                  builder: (controller) {
                    if (controller.shopBalanceApiResponse.status ==
                        Status.COMPLETE) {
                      ShopBalanceResponse response =
                          controller.shopBalanceApiResponse.data;
                      return bigProfileHeader(
                        context,
                        route: 'ArtistUserProfileScreen',
                      );
                    }

                    return bigProfileHeader(
                      context,
                      route: 'ArtistUserProfileScreen',
                    );
                  },
                ),
                panel: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      )),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.height * 0.02),
                      child: Obx(() {
                        return Text(
                          pageChange.value == 0
                              ? "Appointment History"
                              : pageChange.value == 1
                                  ? "Book Appointment"
                                  : "Appointment Pending",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Get.height * 0.025),
                        );
                      }),
                    ),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(left: 7),
                                  child: Container(
                                    height: Get.height * 0.007,
                                    width: pageChange.value == index
                                        ? Get.width * 0.05
                                        : Get.width * 0.02,
                                    decoration: BoxDecoration(
                                        color: cRoyalBlue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                )),
                      );
                    }),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Expanded(
                      child: PageView(
                        onPageChanged: (val) {
                          pageChange.value = val;
                        },
                        controller: pageController,
                        children: [
                          bookAppointmentPage(),
                          appointmentHistoryPage(),
                          pendingAppointmentPage()
                        ],
                      ),
                    ),
                  ]),
                ),
                minHeight: Get.height * 0.43,
                maxHeight: Get.height * 0.68,
                backdropEnabled: true,
                color: Colors.transparent,
              )*/
          ),
        ),
      ),
    );
  }

  SingleChildScrollView appointmentHistoryPage() {
    return SingleChildScrollView(
      child: GetBuilder<AppointmentViewModel>(
        builder: (controller) {
          if (controller.modelHistoryAppointmentApiResponse.status ==
              Status.LOADING) {
            return Center(child: circularIndicator());
          }
          if (controller.modelHistoryAppointmentApiResponse.status ==
              Status.ERROR) {
            return Center(child: Text("Server Error"));
          }

          ModelAppointmentHistoryResponse response =
              controller.modelHistoryAppointmentApiResponse.data;
          if (response.data.length >= 0 || response.data.isEmpty) {
            return Center(
                child: Padding(
              padding: EdgeInsets.only(top: Get.height * 0.1),
              child: Text("No Appointment History"),
            ));
          }
          return Column(
            children: List.generate(
              response.data.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.023),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    Container(
                      height: Get.height * 0.09,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 5)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: Get.height * 0.02,
                            top: Get.height * 0.01,
                            left: Get.height * 0.02,
                            bottom: Get.height * 0.01),
                        child: Row(
                          children: [
                            response.data[index].image == null ||
                                    response.data[index].image == ''
                                ? imageNotFound()
                                : ClipOval(
                                    child: commonProfileOctoImage(
                                      image: response.data[index].image,
                                      height: Get.height * 0.07,
                                      width: Get.height * 0.07,
                                    ),
                                  ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    response.data[index].serviceName ?? "",
                                    style: TextStyle(
                                        fontSize: Get.height * 0.018,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins"),
                                  ),
                                  // showRattingBar(
                                  //     response.data[index].rating ?? 0.0)
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    " ${DateFormat('dd.MM.yy').format(response.data[index].startTime ?? "")}",
                                    style: TextStyle(
                                        fontSize: Get.height * 0.016,
                                        fontFamily: "Poppins"),
                                  ),
                                  Text(
                                    "${DateFormat.jm().format(response.data[index].startTime ?? "")}",
                                    style: TextStyle(
                                        fontSize: Get.height * 0.016,
                                        fontFamily: "Poppins"),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(ChatScreen(
                                  userImg: response.data[index].image,
                                  userName: response.data[index].artistName,
                                  receiverId:
                                      response.data[index].modelId.toString(),
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
                      ),
                    ),

                    /*Slidable(
                      actionExtentRatio: 0.22,
                      actionPane: SlidableDrawerActionPane(),
                      child: Container(
                        height: Get.height * 0.09,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 5)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: Get.height * 0.02,
                              top: Get.height * 0.01,
                              bottom: Get.height * 0.01),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: response.data[index].image == null ||
                                        response.data[index].image == ''
                                    ? imageNotFound()
                                    : ClipOval(
                                        child: commonProfileOctoImage(
                                          image: response.data[index].image,
                                          height: Get.height * 0.07,
                                          width: Get.height * 0.07,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      response.data[index].serviceName ?? "",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.018,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins"),
                                    ),
                                    // showRattingBar(
                                    //     response.data[index].rating ?? 0.0)
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   width: Get.width * 0.12,
                              // ),

                              // SizedBox(
                              //   width: Get.width * 0.11,
                              // ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      " ${DateFormat('dd.MM.yy').format(response.data[index].startTime ?? "")}",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.016,
                                          fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "${DateFormat.jm().format(response.data[index].startTime ?? "")}",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.016,
                                          fontFamily: "Poppins"),
                                    )
                                  ],
                                ),
                              ),
                              */ /*   SizedBox(
                                width: Get.width * 0.03,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: SvgPicture.asset(
                                  "assets/image/menu.svg",
                                  height: Get.height * 0.02,
                                ),
                              ),*/ /*
                            ],
                          ),
                        ),
                      ),
                      secondaryActions: [
                        GestureDetector(
                          onTap: () {
                            BottomBarViewModel _barController = Get.find();

                            _barController.setSelectedRoute("UserListChat");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                                height: Get.height * 0.09,
                                decoration: BoxDecoration(
                                    color: cRoyalBlue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/svg/chat.svg",
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),*/
                    SizedBox(
                      height: Get.height * 0.02,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SingleChildScrollView bookAppointmentPage() {
    return SingleChildScrollView(
      child: GetBuilder<AppointmentViewModel>(
        builder: (controller) {
          if (controller.modelBookedAppointmentApiResponse.status ==
              Status.LOADING) {
            return Center(child: circularIndicator());
          }
          if (controller.modelBookedAppointmentApiResponse.status ==
              Status.ERROR) {
            return Center(child: Text("Server Error"));
          }
          ModelAppointmentBookedResponse response =
              controller.modelBookedAppointmentApiResponse.data;
          if (response.data.isEmpty) {
            return Center(
                child: Padding(
              padding: EdgeInsets.only(top: Get.height * 0.1),
              child: Text("No Appointment booked"),
            ));
          }
          return Column(
            children: List.generate(
              response.data.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.023),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(ConfirmBookingScreen(
                          selectedTime: response.data[index].approvedTime,
                          artistId: response.data[index].artistId.toString(),
                          price: response.data[index].price.toString(),
                          servicrId: response.data[index].serviceId.toString(),
                          startTime: response.data[index].startTime.toString(),
                          appointmentId: response.data[index].id,
                        ));
                      },
                      child: Container(
                        height: Get.height * 0.09,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 5)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: Get.height * 0.02,
                              top: Get.height * 0.01,
                              left: Get.height * 0.02,
                              bottom: Get.height * 0.01),
                          child: Row(
                            children: [
                              response.data[index].image == null ||
                                      response.data[index].image == ''
                                  ? imageNotFound()
                                  : ClipOval(
                                      child: commonProfileOctoImage(
                                        image: response.data[index].image,
                                        height: Get.height * 0.07,
                                        width: Get.height * 0.07,
                                      ),
                                    ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      response.data[index].serviceName ?? "",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.018,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins"),
                                    ),
                                    // showRattingBar(
                                    //     response.data[index].rating ?? 0.0)
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      " ${DateFormat('dd.MM.yy').format(response.data[index].startTime ?? "")}",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.016,
                                          fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "${DateFormat.jm().format(response.data[index].startTime ?? "")}",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.016,
                                          fontFamily: "Poppins"),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(ChatScreen(
                                    userImg: response.data[index].image,
                                    userName: response.data[index].artistName,
                                    receiverId:
                                        response.data[index].modelId.toString(),
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
                        ),
                      ),
                    ),
                    /*Slidable(
                      actionExtentRatio: 0.22,
                      actionPane: SlidableDrawerActionPane(),
                      child: Container(
                        height: Get.height * 0.09,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 5)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: Get.height * 0.02,
                              top: Get.height * 0.01,
                              bottom: Get.height * 0.01),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: response.data[index].image == null ||
                                        response.data[index].image == ''
                                    ? imageNotFound()
                                    : ClipOval(
                                        child: commonProfileOctoImage(
                                          image: response.data[index].image,
                                          height: Get.height * 0.07,
                                          width: Get.height * 0.07,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      response.data[index].serviceName ?? "",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.018,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins"),
                                    ),
                                    // showRattingBar(
                                    //     response.data[index].rating ?? 0.0)
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      " ${DateFormat('dd.MM.yy').format(response.data[index].startTime ?? "")}",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.016,
                                          fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "${DateFormat.jm().format(response.data[index].startTime ?? "")}",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.016,
                                          fontFamily: "Poppins"),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                             */ /* Align(
                                alignment: Alignment.topRight,
                                child: SvgPicture.asset(
                                  "assets/image/menu.svg",
                                  height: Get.height * 0.02,
                                ),
                              ),*/ /*
                            ],
                          ),
                        ),
                      ),
                      secondaryActions: [
                        GestureDetector(
                          onTap: () {
                            BottomBarViewModel _barController = Get.find();

                            _barController.setSelectedRoute("UserListChat");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                                height: Get.height * 0.09,
                                decoration: BoxDecoration(
                                    color: cRoyalBlue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/svg/chat.svg",
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),*/
                    SizedBox(
                      height: Get.height * 0.02,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SingleChildScrollView pendingAppointmentPage() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: GetBuilder<AppointmentViewModel>(
        builder: (controller) {
          if (controller.pendingAppointmentApiResponse.status ==
              Status.LOADING) {
            return Center(child: circularIndicator());
          }
          if (controller.pendingAppointmentApiResponse.status == Status.ERROR) {
            return Center(child: Text("Server Error"));
          }
          ModelAppointmentPendingResponse response =
              controller.pendingAppointmentApiResponse.data;
          if (response.data.isEmpty) {
            return Center(
                child: Padding(
              padding: EdgeInsets.only(top: Get.height * 0.1),
              child: Text("No Appointment booked"),
            ));
          }
          return Column(
            children: List.generate(
              response.data.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.height * 0.023),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    Container(
                      height: Get.height * 0.09,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 5)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: Get.height * 0.02,
                            top: Get.height * 0.01,
                            left: Get.height * 0.02,
                            bottom: Get.height * 0.01),
                        child: Row(
                          children: [
                            response.data[index].image == null ||
                                    response.data[index].image == ''
                                ? imageNotFound()
                                : ClipOval(
                                    child: commonProfileOctoImage(
                                      image: response.data[index].image,
                                      height: Get.height * 0.07,
                                      width: Get.height * 0.07,
                                    ),
                                  ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    response.data[index].serviceName ?? '',
                                    style: TextStyle(
                                        fontSize: Get.height * 0.018,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins"),
                                  ),
                                  // showRattingBar(
                                  //     response.data[index].rating ?? 0.0)
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    " ${DateFormat('dd.MM.yy').format(response.data[index].startTime ?? "")}",
                                    style: TextStyle(
                                        fontSize: Get.height * 0.016,
                                        fontFamily: "Poppins"),
                                  ),
                                  Text(
                                    "${DateFormat.jm().format(response.data[index].startTime ?? "")}",
                                    style: TextStyle(
                                        fontSize: Get.height * 0.016,
                                        fontFamily: "Poppins"),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(ChatScreen(
                                  userImg: response.data[index].image,
                                  userName: response.data[index].artistName,
                                  receiverId:
                                      response.data[index].modelId.toString(),
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
                      ),
                    ),
                    /* Slidable(
                      actionExtentRatio: 0.22,
                      actionPane: SlidableDrawerActionPane(),
                      child: Container(
                        height: Get.height * 0.09,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 5)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: Get.height * 0.02,
                              top: Get.height * 0.01,
                              bottom: Get.height * 0.01),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: response.data[index].image == null ||
                                        response.data[index].image == ''
                                    ? imageNotFound()
                                    : ClipOval(
                                        child: commonProfileOctoImage(
                                          image: response.data[index].image,
                                          height: Get.height * 0.07,
                                          width: Get.height * 0.07,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      response.data[index].serviceName ?? '',
                                      style: TextStyle(
                                          fontSize: Get.height * 0.018,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins"),
                                    ),
                                    // showRattingBar(
                                    //     response.data[index].rating ?? 0.0)
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      " ${DateFormat('dd.MM.yy').format(response.data[index].startTime ?? "")}",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.016,
                                          fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "${DateFormat.jm().format(response.data[index].startTime ?? "")}",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.016,
                                          fontFamily: "Poppins"),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                            ],
                          ),
                        ),
                      ),
                      secondaryActions: [
                        GestureDetector(
                          onTap: () {
                            BottomBarViewModel _barController = Get.find();

                            _barController.setSelectedRoute("UserListChat");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                                height: Get.height * 0.09,
                                decoration: BoxDecoration(
                                    color: cRoyalBlue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/svg/chat.svg",
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),*/
                    SizedBox(
                      height: Get.height * 0.02,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
