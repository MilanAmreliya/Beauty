import 'dart:io';

import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_btn.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/view/profileTab/editProfile/widget/edit_profile_form.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/register_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final String image;

  const EditProfileScreen({Key key, this.image}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<FormState> formKey;
  ArtistProfileViewModel artistProfileViewModel = Get.find();
  ValidationViewModel validationController = Get.find();

  RegisterViewModel registerViewModel = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    formKey = GlobalKey<FormState>();
    super.initState();
  }

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
  Widget build(BuildContext context) {
    return Material(
      color: cDarkBlue,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    }),
              ),
            ),
            Container(
              height: Get.width * 0.225,
              width: Get.width * 0.225,
              child: _image == null
                  ? widget.image == null || widget.image == ''
                      ? imageNotFound()
                      : ClipOval(
                          child: commonProfileOctoImage(image: widget.image))
                  : CircleAvatar(
                      radius: Get.height * 0.05,
                      child: ClipOval(
                        child: Image.file(
                          _image,
                          fit: BoxFit.cover,
                          height: Get.height * 0.12,
                          width: Get.width * 0.244,
                        ),
                      ),
                    ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                ));
              },
              child: Text(
                "Update User Profile",
                style: TextStyle(color: cRoyalBlue, fontSize: 20),
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Expanded(
              child: Container(
                // height: Get.height,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40))),
                child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40)),
                    child: ListView(
                      // shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 50),
                      physics: BouncingScrollPhysics(),
                      children: [
                        Form(
                            key: formKey,
                            child: EditProfileForm(
                              formKey: formKey,
                              image: _image,
                            )),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
