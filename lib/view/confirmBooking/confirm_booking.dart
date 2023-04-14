import 'dart:developer';

import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/dialogs/payment_Success_Dialog.dart';
import 'package:beuty_app/googlmap_screen/directions.dart';
import 'package:beuty_app/googlmap_screen/directions_repository.dart';
import 'package:beuty_app/model/apiModel/requestModel/create_appoinment_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/create_appointment_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/complete_appointment_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_shopid_reponce.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/services/stripe_payment_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/payment/payment_home.dart';
import 'package:beuty_app/viewModel/appointment_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ConfirmBookingScreen extends StatefulWidget {
  final String price;
  final String artistId;
  final String servicrId;
  final String startTime;
  final DateTime selectedTime;
  final int appointmentId;

  ConfirmBookingScreen(
      {Key key,
      this.price,
      this.artistId,
      this.servicrId,
      this.startTime,
      this.selectedTime,
      this.appointmentId})
      : super(key: key);

  @override
  _ConfirmBookingScreenState createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  String payment;

  List<Map<String, dynamic>> paymentType = [
    {
      'img': 'assets/image/card1.png',
      'title': 'Stripe Payment',
      "subTitle": "card",
      "index": 1
    },
    /* {
      'img': 'assets/image/card2.png',
      'title': 'Book and pay \ninstore',
      "subTitle": "cash",
      "index": 2
    },*/
  ];
  int x1 = 0;
  double kLatitude = 0.0;
  double kLongitude = 0.0;
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  TextEditingController placeController = TextEditingController();
  Marker _origin;
  Marker _destination;
  DirectionsModel _info;
  BitmapDescriptor pinLocationIconSource, pinLocationIconDestination;

  AppointmentViewModel appointmentViewModel = Get.find();

  HomeTabViewModel homeTabViewModel = Get.find();

  ArtistProfileViewModel artistProfileViewModel = Get.find();

  @override
  void initState() {
    setCustomMapPin();
    geoLocator();
    artistProfileViewModel.getShopByCreate(widget.artistId);
    super.initState();
  }

  Future geoLocator() async {
    var getLocator = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      kLatitude = getLocator.latitude;
      kLongitude = getLocator.longitude;
    });
    print("CURRENT LAT=$kLatitude");
    print("CURRENT LONGI=$kLongitude");
    // setState(() {
    //   kLatitude = 21.2172738;
    //   kLongitude = 72.8869815;
    // });
    x1 = 1;
  }

  void setCustomMapPin() async {
    pinLocationIconSource = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/image/Point.png');
    pinLocationIconDestination = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/image/Pointd.png');
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      log("ORIGIN");
      setState(() {
        _origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          // icon: pinLocationIconSource,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );

        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          // icon: pinLocationIconDestination,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkResponse(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: cRoyalBlue,
            size: Get.height * 0.027,
          ),
        ),
        title: Text(
          PreferenceManager.getUserName(),
          style: TextStyle(color: cRoyalBlue, fontSize: Get.height * 0.025),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Image.asset(
                    "assets/image/calender.png",
                    height: Get.height * 0.13,
                  ),
                  Text(
                    "${DateFormat.yMMMMd().format(widget.selectedTime)}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        fontSize: Get.height * 0.027),
                  ),
                  Text(
                    "${DateFormat.EEEE().format(widget.selectedTime) ?? ""} ${DateFormat.jm().format(widget.selectedTime) ?? ""}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        fontSize: Get.height * 0.017),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  GetBuilder<ArtistProfileViewModel>(
                    builder: (controller) {
                      if (controller.shopIdApiResponse.status ==
                          Status.COMPLETE) {
                        GetShopId response = controller.shopIdApiResponse.data;
                        return Text(
                          response.data.name ?? 'N/A',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              fontSize: Get.height * 0.02),
                        );
                      }
                      if (controller.shopIdApiResponse.status == Status.ERROR) {
                        return Center(child: Text("Server Error"));
                      }
                      return Center(child: circularIndicator());
                    },
                  ),

                  ///MAP
                  x1 == 0
                      ? CircularProgressIndicator()
                      : Container(
                          height: Get.height * 0.24,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.7)),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GoogleMap(
                              myLocationButtonEnabled: false,
                              zoomControlsEnabled: true,
                              zoomGesturesEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(kLatitude, kLongitude),
                                zoom: 13,
                              ),
                              onMapCreated: (controller) {
                                ///current lan-long
                                _addMarker(LatLng(kLatitude, kLongitude));

                                /// destination lat-long
                                GetShopId response = artistProfileViewModel
                                    .shopIdApiResponse.data;
                                double klati = double.parse(response.data.lati);
                                double klongi =
                                    double.parse(response.data.longi);
                                print("shop lati:$klati");
                                print("shop longi:$klongi");
                                _addMarker(LatLng(klati, klongi));
                              },

                              markers: {
                                if (_origin != null) _origin,
                                if (_destination != null) _destination
                              },
                              polylines: {
                                if (_info != null)
                                  Polyline(
                                    polylineId: PolylineId('overview_polyline'),
                                    color: Color(0Xff626262),
                                    width: 5,
                                    points: _info.polylinePoints
                                        .map((e) =>
                                            LatLng(e.latitude, e.longitude))
                                        .toList(),
                                  ),
                              },
                              // onLongPress: _addMarker,
                            ),
                          ),
                        ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/location.svg",
                        height: Get.height * 0.035,
                      ),
                      Text(
                        "Directions",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontSize: Get.height * 0.02),
                      ),
                      Spacer(),
                      Text(
                        "View On Tap",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontSize: Get.height * 0.02),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Text(
                    "Process to Payment",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        fontSize: Get.height * 0.022),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: paymentType
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            // appointmentViewModel.setPaymentType(e["subTitle"]);
                            // print(appointmentViewModel.paymentType);
                          },
                          child: Column(
                            children: [
                              GetBuilder<AppointmentViewModel>(
                                builder: (controller) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Image.asset(
                                        e["img"],
                                        height: Get.height * 0.15,
                                        width: Get.width * 0.4,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Text(
                                e["title"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Get.height * 0.02),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList()),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Center(
              child: customBtn(
                  title: 'Payment',
                  fontSize: Get.height * 0.02,
                  height: Get.height * 0.055,
                  width: Get.width * 0.5,
                  radius: Get.width * 0.09,
                  onTap: () async {
                    /*  Get.to(PaymentScreen(
                      amount: widget.price,
                    ));*/
                    payViaNewCard(context, widget.appointmentId);
                  }),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }

  payViaNewCard(BuildContext context, int appointmentId) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response = await StripeService.payWithNewCard(
        amount: (double.parse(widget.price).ceil() * 100).toString(),
        currency: 'USD');
    await dialog.hide();
    CommanWidget.snackBar(message: response.message);
    if (response.message == 'Transaction successful') {
      completeAppointmentCall(appointmentId.toString());
    }
  }

  Future<void> completeAppointmentCall(String appointmentId) async {
    await appointmentViewModel.completeAppointment(appointmentId);
    if (appointmentViewModel.completeAppointmentRepoApiResponse.status ==
        Status.COMPLETE) {
      CompleteAppointmentResponse response =
          appointmentViewModel.completeAppointmentRepoApiResponse.data;
      if (response.success == true) {
        BottomBarViewModel _bottomViewModel = Get.find();
        _bottomViewModel.setSelectedIndex(0);
        _bottomViewModel.setSelectedRoute('HomeScreen');
      } else {
        CommanWidget.snackBar(
            message: response.message ?? 'Something want wrong');
      }
    } else {
      CommanWidget.snackBar(message: 'Something want wrong');
    }
  }
}
