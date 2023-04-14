import 'dart:developer';
import 'dart:io';

import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/model/apiModel/requestModel/add_shop_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_place.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/bottomBar/bottom_bar.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class CreateShopForm extends StatefulWidget {
  final bool firstTimeCreate;

  const CreateShopForm({Key key, this.firstTimeCreate}) : super(key: key);

  @override
  _CreateShopFormState createState() => _CreateShopFormState();
}

class _CreateShopFormState extends State<CreateShopForm> {
  ValidationViewModel validationController = Get.find();
  TextEditingController shopNameTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController aboutTextEditingController = TextEditingController();
  TextEditingController mapTextEditingController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  List<Marker> myMarker = [];
  List<LatLng> _polylineCoordinates = [];
  ArtistProfileViewModel artistProfileViewModel = Get.find();
  GoogleMapController controller;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  double CAMERA_TILT = 0;
  double CAMERA_BEARING = 30;
  dynamic kLatitude = 0.0;
  dynamic kLongitude = 0.0;

  // LatLng SOURCE_LOCATION = LatLng(21.2172738, 72.8869815);
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  PolylinePoints _polylinePoints = PolylinePoints();

  // List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  File _image;
  final picker = ImagePicker();

  Future geoLocator() async {
    var getLocator = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      kLatitude = getLocator.latitude;
      kLongitude = getLocator.longitude;
    });
    x1 = 1;
    // log("LAT${kLatitude} LONG ${kLongitude}");
  }

  Future getGalleryImage() async {
    var imaGe = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (imaGe != null) {
        _image = File(imaGe.path);
        print("=======================imagepathe${imaGe.path}");

        imageCache.clear();
      } else {
        print('no image selected');
      }
    });
  }

  Future getCamaroImage() async {
    var imaGe = await picker.getImage(source: ImageSource.camera);
    print("=======================imagepathe${imaGe.path}");

    setState(() {
      if (imaGe != null) {
        _image = File(imaGe.path);
        print("=======================imagepathe${_image}");
        print("=======================imagepathe${imaGe.path}");

        imageCache.clear();
      } else {
        print('no image selected');
      }
    });
  }

  int x1 = 0;

  @override
  void initState() {
    // TODO: implement initState
    _setMapPins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewPadding.bottom),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(35))),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(40)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          ///GALLARY
                          GestureDetector(
                            onTap: () {
                              Get.dialog(Center(
                                child: Container(
                                  height: Get.height * 0.2,
                                  width: Get.width * 0.5,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: cLightGrey)),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        customBtn(
                                            onTap: () {
                                              Get.back();
                                              getGalleryImage();
                                            },
                                            title: 'Gallery',
                                            height: Get.height * 0.06,
                                            width: Get.width * 0.3,
                                            fontSize: Get.height * 0.023),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        customBtn(
                                            onTap: () {
                                              Get.back();
                                              getCamaroImage();
                                            },
                                            title: 'Camera',
                                            height: Get.height * 0.06,
                                            width: Get.width * 0.3,
                                            fontSize: Get.height * 0.023),
                                      ],
                                    ),
                                  ),
                                ),
                              )); // ho
                            },
                            child: Container(
                              height: Get.height * 0.2,
                              width: Get.width,
                              //color: Colors.deepPurple,
                              decoration: BoxDecoration(
                                //color: Colors.deepOrange,
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.7)),
                                color: Colors.white,
                              ),
                              child: _image == null
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          svgAddPhoto,
                                          Text(
                                            " Add photo",
                                            style: TextStyle(color: cLightGrey),
                                          )
                                        ],
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        _image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),

                          ///SHOP NAME
                          CommanWidget.getTextFormField(
                            labelText: "",
                            textEditingController:
                                shopNameTextEditingController,
                            hintText: "Shop Name",
                            inputLength: 30,
                            regularExpression:
                                Utility.alphabetSpaceValidationPattern,
                            validationMessage: Utility.nameEmptyValidation,
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          ///PLACE
                          GetBuilder<ArtistProfileViewModel>(
                            builder: (controller) {
                              return controller.getPlaceApiResponse.status ==
                                      Status.COMPLETE
                                  ? categoryDropdown(
                                      data: (controller.getPlaceApiResponse.data
                                              as GetPlaceResponse)
                                          .data,
                                      onTap: (value) {
                                        placeController.text = value.toString();
                                      })
                                  : categoryDropdown(
                                      data: [], onTap: (value) {});
                            },
                          ),

                          ///SHOP ADDRESS
                          CommanWidget.getTextFormField(
                            labelText: "",
                            textEditingController: addressTextEditingController,
                            hintText: "Address",
                            inputLength: 30,
                            regularExpression: Utility.addressValidationPattern,
                            validationMessage: Utility.addressEmptyValidation,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          ///MAP
                          x1 == 0
                              ? CircularProgressIndicator()
                              : Container(
                                  height: Get.height * 0.25,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.7)),
                                    color: Colors.white,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: GoogleMap(
                                      markers: Set.from(myMarker),
                                      onMapCreated: _onMapCreated,
                                      initialCameraPosition: CameraPosition(
                                          zoom: 13,
                                          bearing: CAMERA_BEARING,
                                          tilt: CAMERA_TILT,
                                          target:
                                              LatLng(kLatitude, kLongitude)),
                                      mapType: MapType.normal,
                                      onTap: _onTapChangLocation,
                                    ),
                                  ),
                                ),

                          ///ABOUT ADDRESS
                          CommanWidget.getTextFormField(
                            labelText: "",
                            textEditingController: aboutTextEditingController,
                            hintText: "About",
                            maxLine: 3,
                            inputLength: 30,
                            regularExpression: Utility.addressValidationPattern,
                            validationMessage: Utility.aboutEmptyValidation,
                          ),
                          CommanWidget.sizedBox20()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CommanWidget.sizedBox6_5(),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width / 6),
                  child: CommanWidget.activeButton(
                      onTap: () {
                        // BottomBarViewModel _barController = Get.find();
                        //
                        // _barController.setSelectedRoute('ShopScreen');

                        sendData(formKey);
                      },
                      title: 'Create')),
              CommanWidget.sizedBox6_5(),
            ],
          ),
        ),
        GetBuilder<ArtistProfileViewModel>(
          builder: (controller) {
            if (controller.apiResponse.status == Status.LOADING) {
              return loadingIndicator();
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    controller = controllerParam;
    setState(() {
      _setMapPins();
      _setPolylines();
    });
  }

  Future<void> _setMapPins() async {
    // log("LAT mpin ${kLatitude} LONG ${kLongitude}");

    await geoLocator();
    log("LAT mpin 2${kLatitude} LONG ${kLongitude}");

    myMarker.add(Marker(
      markerId: MarkerId("sourcePin"),
      position: LatLng(kLatitude, kLongitude),
    ));
    setState(() {});
  }

  _setPolylines() async {
    PolylineResult result = await _polylinePoints
        .getRouteBetweenCoordinates(
            Utility.googleMapKey,
            PointLatLng(kLatitude, kLongitude),
            PointLatLng(kLatitude, kLongitude),
            travelMode: TravelMode.driving)
        .then((value) {
      print('dd=>${value.points} ${value.status}');
      if (value.points.isNotEmpty) {
        value.points.forEach((PointLatLng point) {
          _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      Polyline polyline = Polyline(
          polylineId: PolylineId('s'),
          color: Color.fromARGB(255, 40, 122, 198),
          points: _polylineCoordinates);
      _polylines.add(polyline);
    }).catchError((e) => log('ERROR+>$e'));
  }

  _onTapChangLocation(LatLng tappedPoint) {
    print("============================tapprd=$tappedPoint");

    setState(
      () {
        myMarker = [];
        myMarker.add(
          Marker(
            markerId: MarkerId(
              tappedPoint.toString(),
            ),
            position: tappedPoint,
          ),
        );
        log("========log${tappedPoint.latitude}");
        log("========log${tappedPoint.latitude}");
      },
    );
    kLongitude = tappedPoint.longitude;
    kLatitude = tappedPoint.latitude;
    print("=========new =================klongitut=$kLongitude");
    print("=========new =================klongitut=$kLatitude");
  }

  Widget categoryDropdown({List data, Function onTap}) {
    return DropdownButtonFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: data.isEmpty
          ? []
          : (data as List<PlaceDatum>)
              .map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.placeName),
                  ))
              .toList(),
      isExpanded: true,
      value: null,
      validator: (value) {
        if (value == null || value == '') {
          return '* Required';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
        errorBorder: CommanWidget.outLineRed,
        focusedErrorBorder: CommanWidget.outLineRed,
        focusedBorder: CommanWidget.outLineGrey,
        enabledBorder: CommanWidget.outLineGrey,
      ),
      style: TextStyle(color: Colors.black, fontSize: 14),
      hint: Text('Place'),
      onChanged: onTap,
    );
  }

  Future<void> sendData(GlobalKey<FormState> formKey) async {
    ValidationViewModel controller = Get.find();

    if (formKey.currentState.validate()) {
      if (_image == null) {
        CommanWidget.snackBar(
          message: "Please choose image",
        );
        return;
      }
      validationController.progressVisible.value = true;
      // FocusScope.of(context).unfocus();

      BottomBarViewModel _barController = Get.find();
      CreateShopReqModel createShopReq = CreateShopReqModel();
      createShopReq.img = _image.path;
      createShopReq.name = shopNameTextEditingController.text;
      createShopReq.place = placeController.text;
      createShopReq.adreess = addressTextEditingController.text;
      createShopReq.lati = kLatitude.toString();
      createShopReq.longi = kLongitude.toString();
      createShopReq.artistId = PreferenceManager.getArtistId().toString();
      createShopReq.aboutShop = aboutTextEditingController.text;

      await artistProfileViewModel.createShop(createShopReq);
      if (artistProfileViewModel.apiResponse.status == Status.COMPLETE) {
        PostSuccessResponse response = artistProfileViewModel.apiResponse.data;
        if (response.success) {
          CommanWidget.snackBar(
            message: response.message,
          );
          await PreferenceManager.setCustomerRole(
              'Artist');
          controller.updateRole('Artist');

          Future.delayed(Duration(seconds: 1), () {
            if (!widget.firstTimeCreate) {
              _barController.setSelectedRoute('ShopScreen');
            } else {
              BottomBarViewModel _barController = Get.find();
              _barController.setSelectedIndex(0);
              _barController.setSelectedRoute('HomeScreen');

              Get.offAll(BottomBar());
            }
          });
        }
      } else {
        CommanWidget.snackBar(
          message: "Server Error",
        );
      }
    }
  }
}
