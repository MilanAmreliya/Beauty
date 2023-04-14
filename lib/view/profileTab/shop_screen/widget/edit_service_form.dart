import 'dart:developer';
import 'dart:io';

import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/requestModel/update_service_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_category_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_service_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/update_service_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/get_category_viewModel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditServiceForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const EditServiceForm({Key key, this.formKey}) : super(key: key);

  @override
  _EditServiceFormState createState() => _EditServiceFormState();
}

class _EditServiceFormState extends State<EditServiceForm> {
  ValidationViewModel validationController = Get.find();
  TextEditingController serviceNameTextEditingController =
      TextEditingController();
  TextEditingController categoryTextEditingController = TextEditingController();
  TextEditingController priceTextEditingController = TextEditingController();
  TextEditingController tagsTextEditingController = TextEditingController();
  TextEditingController startTextEditingController = TextEditingController();
  TextEditingController endTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  ArtistProfileViewModel artistProfileViewModel = Get.find();
  GetCategoryViewModel getCategoryViewModel = Get.find();
  HomeTabViewModel homeTabViewModel = Get.find();
  final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  String servImg;
  File _image;
  final picker = ImagePicker();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print(homeTabViewModel.serviceId.value);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<ArtistProfileViewModel>(
                builder: (controller) {
                  print(controller.getServiceApiResponse.status);
                  if (controller.getServiceApiResponse.status !=
                      Status.COMPLETE) {
                    return Center(child: circularIndicator());
                  }
                  if (controller.getServiceApiResponse.status == Status.ERROR) {
                    return Center(child: Text("Server Error"));
                  }

                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(35))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewPadding.bottom),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(40)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                CommanWidget.sizedBox15(),

                                ///GALLARY
                                GestureDetector(
                                  onTap: () {
                                    Get.dialog(Center(
                                      child: Container(
                                        height: Get.height * 0.2,
                                        width: Get.width * 0.5,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: cLightGrey)),
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
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              "https://vid-mates.com/abir/beauty-app4/public/${servImg}",
                                              fit: BoxFit.cover,
                                            ))
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              _image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),

                                ///SERVICE NAME
                                CommanWidget.getTextFormField(
                                  labelText: "",
                                  textEditingController:
                                      serviceNameTextEditingController,
                                  hintText: "Service name",
                                  inputLength: 30,
                                  regularExpression:
                                      Utility.alphabetSpaceValidationPattern,
                                  validationMessage:
                                      'Service name' + Utility.isRequired,
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                                GetBuilder<GetCategoryViewModel>(
                                  builder: (controller) {
                                    return controller.apiResponse.status ==
                                            Status.COMPLETE
                                        ? categoryDropdown(
                                            data: (controller.apiResponse.data
                                                    as GetCategoryResponse)
                                                .data,
                                            onTap: (value) {
                                              categoryTextEditingController
                                                  .text = value.toString();
                                            })
                                        : categoryDropdown(
                                            data: [], onTap: (value) {});
                                  },
                                ),

                                ///PRICE...
                                CommanWidget.getTextFormField(
                                  labelText: "",
                                  textInputType: TextInputType.number,
                                  textEditingController:
                                      priceTextEditingController,
                                  inputLength: 14,
                                  regularExpression:
                                      Utility.digitsValidationPattern,
                                  validationMessage:
                                      'Price' + Utility.isRequired,
                                  hintText: "Price",
                                ),

                                ///Start From

                                CommanWidget.getTextFormField(
                                    isReadOnly: true,
                                    labelText: "",
                                    textEditingController:
                                        startTextEditingController,
                                    hintText: "Start from",
                                    inputLength: 30,
                                    regularExpression: Utility.allowedPattern,
                                    validationMessage:
                                        'Start From' + Utility.isRequired,
                                    onTap: () async {
                                      DateTime currentValue = DateTime.now();
                                      final date = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime.now()
                                              .subtract(Duration(days: 0)),
                                          initialDate:
                                              currentValue ?? DateTime.now(),
                                          lastDate: DateTime(2100));
                                      if (date != null) {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              currentValue ?? DateTime.now()),
                                        );
                                        DateTime date1 =
                                            DateTimeField.combine(date, time);
                                        print("time$date1");
                                        setState(() {
                                          startTextEditingController.text =
                                              '${date1.year}-${date1.month}-${date1.day} ${date1.hour}:${date1.minute}:00';
                                        });
                                      } else {
                                        return;
                                      }
                                    }),

                                ///End at

                                CommanWidget.getTextFormField(
                                    isReadOnly: true,
                                    labelText: "",
                                    textEditingController:
                                        endTextEditingController,
                                    hintText: "End at",
                                    inputLength: 30,
                                    regularExpression: Utility.allowedPattern,
                                    validationMessage:
                                        'End at' + Utility.isRequired,
                                    onTap: () async {
                                      DateTime currentValue = DateTime.now();
                                      final date = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime.now()
                                              .subtract(Duration(days: 0)),
                                          initialDate:
                                              currentValue ?? DateTime.now(),
                                          lastDate: DateTime(2100));
                                      if (date != null) {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              currentValue ?? DateTime.now()),
                                        );
                                        DateTime date1 =
                                            DateTimeField.combine(date, time);
                                        print("time$date1");
                                        setState(() {
                                          endTextEditingController.text =
                                              '${date1.year}-${date1.month}-${date1.day} ${date1.hour}:${date1.minute}:00';
                                        });
                                      } else {
                                        return;
                                      }
                                    }),

                                ///Description
                                CommanWidget.getTextFormField(
                                  labelText: "",
                                  textEditingController:
                                      descriptionTextEditingController,
                                  hintText: "Description",
                                  maxLine: 3,
                                  inputLength: 30,
                                  regularExpression:
                                      Utility.addressValidationPattern,
                                  validationMessage:
                                      'Description' + Utility.isRequired,
                                ),
                                CommanWidget.sizedBox20()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              CommanWidget.sizedBox6_5(),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Get.width / 6),
                  child: CommanWidget.activeButton(
                      onTap: () {
                        // print('cat ${categoryTextEditingController.text}');
                        sendData(widget.formKey);
                      },
                      title: "Update")),
              CommanWidget.sizedBox6_5(),
            ],
          ),
        ),
        GetBuilder<ArtistProfileViewModel>(
          builder: (controller) {
            if (artistProfileViewModel.updateServiceApiResponse.status ==
                Status.LOADING) {
              return loadingIndicator();
            } else {
              return SizedBox();
            }
          },
        )
      ],
    );
  }

  Widget categoryDropdown({List data, Function onTap}) {
    // categoryTextEditingController.text='${(data as List<Datum>)[int.parse(categoryTextEditingController.text)].serviceCategoryName}';
    return DropdownButtonFormField(
      items: data.isEmpty
          ? []
          : (data as List<Datum>)
              .map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.serviceCategoryName),
                  ))
              .toList(),
      isExpanded: true,
      value: int.parse(categoryTextEditingController.text),
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
      onChanged: onTap,
    );
  }

  Future<void> sendData(GlobalKey<FormState> formKey) async {
    if (formKey.currentState != null) {
      if (formKey.currentState.validate()) {
        log("IMG ${_image}");

        log("REQUEST IMG ${servImg}");
        validationController.progressVisible.value = true;
        // FocusScope.of(context).unfocus();
        if (_image == null) {
          Utility.isImageChange = false;
        }
        UpdateServiceReqModel updateServiceReqModel = UpdateServiceReqModel();
        updateServiceReqModel.image = _image == null ? "$servImg" : _image.path;
        updateServiceReqModel.serviceName =
            serviceNameTextEditingController.text;
        updateServiceReqModel.categoryId = categoryTextEditingController.text;
        updateServiceReqModel.price = priceTextEditingController.text;
        updateServiceReqModel.startFrom = startTextEditingController.text;
        updateServiceReqModel.endAt = endTextEditingController.text;
        updateServiceReqModel.description =
            descriptionTextEditingController.text;
        await artistProfileViewModel.updateService(updateServiceReqModel);
        log(artistProfileViewModel.updateServiceApiResponse.status.toString());
        if (artistProfileViewModel.updateServiceApiResponse.status ==
            Status.COMPLETE) {
          UpdateServiceResponse response =
              artistProfileViewModel.updateServiceApiResponse.data;
          if (response.success) {
            BottomBarViewModel _barController = Get.find();

            _barController.setSelectedRoute('ArtistProfileServices');

            Utility.isImageChange = true;
            CommanWidget.snackBar(
              message: response.message,
            );
          } else {
            CommanWidget.snackBar(
              message: "Server Error",
            );
          }
        } else {
          CommanWidget.snackBar(
            message: "Server Error",
          );
        }
      } else {
        CommanWidget.snackBar(
          message: Utility.somethingWentToWrong,
        );
      }
    }
  }

  Future getData() async {
    await artistProfileViewModel.getService(homeTabViewModel.serviceId.value);
    GetServiceResponse response =
        artistProfileViewModel.getServiceApiResponse.data;

    servImg = artistProfileViewModel.getServiceApiResponse.data.image;
    print("img:--->$servImg");
    log("GET IMG ${"https://vid-mates.com/abir/beauty-app4/public/${servImg}"}");
    serviceNameTextEditingController.text = response.serviceName;
    categoryTextEditingController.text = response.serviceCategoryId.toString();
    priceTextEditingController.text = response.price.toString();
    startTextEditingController.text = response.startTime.toString();
    endTextEditingController.text = response.endTime.toString();
    descriptionTextEditingController.text = response.description;
  }
}
