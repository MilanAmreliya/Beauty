import 'dart:io';

import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/model/apiModel/requestModel/update_profile_image_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/update_profile_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/update_profile_image_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/update_profile_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/register_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final File image;

  const EditProfileForm({
    Key key,
    this.formKey,
    this.image,
  }) : super(key: key);

  // const EditProfileForm(GlobalKey<FormState> formKey, {Key key}) : super(key: key);

  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  ValidationViewModel validationController = Get.find();

  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController bioTextEditingController = TextEditingController();
  ArtistProfileViewModel artistProfileViewModel = Get.find();

  RegisterViewModel registerViewModel = Get.find();

  @override
  void initState() {
    super.initState();
    userNameTextEditingController =
        TextEditingController(text: PreferenceManager.getUserName());
    nameTextEditingController =
        TextEditingController(text: PreferenceManager.getName());
    bioTextEditingController =
        TextEditingController(text: PreferenceManager.getBio());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height / 25,
                ),

                ///name
                CommanWidget.getTextFormField(
                    labelText: "Name",
                    textEditingController: nameTextEditingController,
                    hintText: "Enter name",
                    inputLength: 30,
                    isIcon: 'isIcon',
                    regularExpression: Utility.alphabetSpaceValidationPattern,
                    validationMessage: Utility.nameEmptyValidation,
                    sIcon: Icon(
                      Icons.person_outline_outlined,
                      color: cLightGrey,
                    )),

                ///username
                CommanWidget.getTextFormField(
                    labelText: "Username",
                    textEditingController: userNameTextEditingController,
                    hintText: "Enter user name",
                    inputLength: 30,
                    isIcon: 'isIcon',
                    regularExpression: Utility.alphabetSpaceValidationPattern,
                    validationMessage: Utility.userNameEmptyValidation,
                    sIcon: Icon(
                      Icons.person_outline_outlined,
                      color: cLightGrey,
                    )),

                ///username
                CommanWidget.getTextFormField(
                  labelText: "Bio",
                  textEditingController: bioTextEditingController,
                  hintText: "Enter your bio",
                  inputLength: 30,
                  isIcon: 'isIcon',
                  regularExpression: Utility.alphabetSpaceValidationPattern,
                  // validationMessage: Utility.userNameEmptyValidation,
                  // sIcon: Icon(
                  //   Icons.person_outline_outlined,
                  //   color: cLightGrey,
                  // )
                ),

                SizedBox(
                  height: 15,
                ),

                SizedBox(
                  height: 25,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.width / 8),
                    child: CommanWidget.activeButton(
                        onTap: () {
                          sendData(widget.formKey, widget.image);
                        },
                        title: 'Update')),
              ],
            ))

        // GetBuilder<RegisterViewModel>(
        //   init: registerViewModel,
        //   builder: (controller) {
        //     if (registerViewModel.apiResponse.status == Status.LOADING) {
        //       return loadingIndicator();
        //     } else {
        //       return SizedBox();
        //     }
        //   },
        // )
      ],
    );
  }

  Future<void> sendData(formKey, image) async {
    if (formKey.currentState != null) {
      if (formKey.currentState.validate()) {
        UpdateProfileReqModel updateProfileReqModel = UpdateProfileReqModel();
        updateProfileReqModel.username = userNameTextEditingController.text;
        updateProfileReqModel.name = nameTextEditingController.text;
        updateProfileReqModel.bio = bioTextEditingController.text;
        await artistProfileViewModel.updateProfile(updateProfileReqModel);
        if (artistProfileViewModel.updateProfileApiResponse.status ==
            Status.COMPLETE) {
          UpdateProfileResponse response =
              artistProfileViewModel.updateProfileApiResponse.data;
          if (response.success) {
            await PreferenceManager.setUserName(
                userNameTextEditingController.text);
            await PreferenceManager.setBio(bioTextEditingController.text);
            await PreferenceManager.setName(nameTextEditingController.text);
            if (image == null) {
              CommanWidget.snackBar(
                message: response.message,
              );
              return;
            }
            await uploadProfilePic(image);
            // CommanWidget.snackBar(
            //   message: response.message,
            // );
            return;
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
          message: Utility.isRequired,
        );
      }
    }
  }

  uploadProfilePic(image) async {
    UpdateProfileImageReqModel updateImageReq = UpdateProfileImageReqModel();
    updateImageReq.image = image.path;
    await artistProfileViewModel.updateProfileImage(updateImageReq);
    if (artistProfileViewModel.updateProfileImageApiResponse.status ==
        Status.COMPLETE) {
      UpdateProfileImageResponse response =
          artistProfileViewModel.updateProfileImageApiResponse.data;
      if (response.status) {
        getArtistDetail();
        CommanWidget.snackBar(
          message: "profile updated successfully",
        );
        return;
      }
    } else {
      CommanWidget.snackBar(
        message: "Server Error",
      );
    }
  }
}

Future<void> getArtistDetail() async {
  ArtistProfileViewModel artistProfileViewModel = Get.find();
  await artistProfileViewModel.getProfileDetail(
      artistId: PreferenceManager.getArtistId().toString());
  if (artistProfileViewModel.artistProfileApiResponse.status ==
      Status.COMPLETE) {
    ArtistProfileDetailResponse response =
        artistProfileViewModel.artistProfileApiResponse.data;
    print('image:${response.data.image}');
    await PreferenceManager.setCustomerPImg(response.data.image);
  }
}
