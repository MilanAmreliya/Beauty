import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/comman/show_ratting_bar.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/model/apiModel/requestModel/create_appoinment_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/selected_service_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/create_appointment_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/confirmBooking/confirm_booking.dart';
import 'package:beuty_app/viewModel/appointment_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookAppointmentScreen extends StatefulWidget {
  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  SelectedServiceModel _serviceModel = SelectedServiceModel();

  BottomBarViewModel _barController = Get.find();

  HomeTabViewModel controller = Get.find();

  TextEditingController startTextEditingController = TextEditingController();

  final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateTime date1;

  @override
  Widget build(BuildContext context) {
    // return SizedBox();
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('ModelProfilePostScreen');

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cDarkBlue,
        appBar: customAppBar(
          'Booking Page',
          leadingOnTap: () {
            _barController.setSelectedRoute('ModelProfilePostScreen');
          },
          action: svgChat(),
        ),
        body: Container(
          height: Get.height,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Center(
                child: Text(
                  "Open Days/Hour",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poopins",
                      fontWeight: FontWeight.w500,
                      fontSize: Get.height * 0.033),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.height * 0.022),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _serviceModel.image == null || _serviceModel.image == ''
                            ? imageNotFound()
                            : ClipOval(
                                child: commonProfileOctoImage(
                                  image: _serviceModel.image,
                                  height: Get.height * 0.07,
                                  width: Get.height * 0.07,
                                ),
                              ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Text(
                          "Book your appointment",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poopins",
                              fontSize: Get.height * 0.025),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      _serviceModel.description ?? 'N/A',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poopins",
                          fontSize: Get.height * 0.02),
                    ),
                    showRattingBar(),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      // height: Get.height * 0.05,
                      decoration: BoxDecoration(
                          border: Border.all(color: cWhite, width: 2),
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Get.width * 0.02,
                            horizontal: Get.height * 0.02),
                        child: Text(
                          "\$${_serviceModel.price ?? ""}",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poopins",
                              fontSize: Get.height * 0.023),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40))),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.height * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                "Start Time : ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * 0.02),
                              ),
                              Text(
                                _serviceModel.startTime == null
                                    ? 'N/A'
                                    : "${DateFormat.jm().format(_serviceModel.startTime) ?? ""}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: Get.height * 0.02),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                "End Time : ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * 0.02),
                              ),
                              Text(
                                _serviceModel.endTime == null
                                    ? "N/A"
                                    : "${DateFormat.jm().format(_serviceModel.endTime) ?? ""}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: Get.height * 0.02),
                              ),
                            ],
                          ),

                          ///Start From

                          CommanWidget.getTextFormField(
                              isReadOnly: true,
                              labelText: "",
                              textEditingController: startTextEditingController,
                              hintText: "Select time",
                              inputLength: 30,
                              regularExpression: Utility.allowedPattern,
                              onTap: () async {
                                DateTime currentValue = DateTime.now();
                                final date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    // _serviceModel.startTime==null||_serviceModel.startTime==""?DateTime.now():_serviceModel.startTime,
                                    // initialDate: currentValue ?? DateTime.now(),
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime(2100));
                                if (date != null) {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        currentValue ?? DateTime.now()),
                                  );
                                  date1 = DateTimeField.combine(date, time);
                                  print("time$date1");
                                  setState(() {
                                    startTextEditingController.text =
                                        '${date1.year}-${date1.month}-${date1.day} ${date1.hour}:${date1.minute}:00';
                                  });
                                } else {
                                  return;
                                }
                              }),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Center(
                            child: customBtn(
                                title: 'CONFIRM',
                                fontSize: Get.height * 0.02,
                                height: Get.height * 0.055,
                                width: Get.width * 0.5,
                                radius: Get.width * 0.09,
                                onTap: () {
                                  if (date1 == null) {
                                    CommanWidget.snackBar(
                                      message: "Please select time",
                                    );
                                    return;
                                  }
                                  confirmOnTap(
                                      artistId: _serviceModel.artistId,
                                      serviceId: _serviceModel.id,
                                      price: _serviceModel.price,
                                      startTime: date1.toString());
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> confirmOnTap(
      {String artistId,
      String serviceId,
      dynamic price,
      String startTime}) async {
    AppointmentViewModel appointmentViewModel = Get.find();
    CreateAppointmentReq createAppointment = CreateAppointmentReq();
    createAppointment.artistId = artistId;
    createAppointment.modelId = PreferenceManager.getArtistId().toString();
    createAppointment.serviceId = serviceId;
    createAppointment.ammount = price.toString();
    createAppointment.paymentType = 'Card';
    createAppointment.startTime = startTime;
    await appointmentViewModel.createAppointment(createAppointment);
    if (appointmentViewModel.createAppointmentApiResponse.status ==
        Status.COMPLETE) {
      CreateAppointmentResponse response =
          appointmentViewModel.createAppointmentApiResponse.data;
      if (response.success) {
        Get.dialog(
          confirmDialog(),
        );
      } else {
        CommanWidget.snackBar(
          message: "Please try again",
        );
      }
    } else {
      CommanWidget.snackBar(
        message: "Server Error",
      );
    }
  }

  AlertDialog confirmDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Text(
          'Your Appointment is Booked, while artist not approve your appointment you will not allow to payments'),
      actions: [
        TextButton(
            onPressed: () async {
              Get.back();
              _barController.setSelectedIndex(2);
            },
            child: Text('OK'))
      ],
    );
  }
}
