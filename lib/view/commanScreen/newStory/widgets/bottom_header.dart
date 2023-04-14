import 'dart:io';
import 'dart:typed_data';

import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/compress_image.dart';
import 'package:beuty_app/comman/get_image_picker.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Padding bottomHeader(BottomBarViewModel _barController) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            NewStoryViewModel newStoryViewModel=Get.find();
            if(newStoryViewModel.selectedImg.value.isEmpty){
              CommanWidget.snackBar(message: 'Please select min one image');
              return;
            }
            _barController.setSelectedRoute('SharePost');
          },
          child: Text('Post',
              style: TextStyle(
                  color: cLightGrey,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 19)),
        ),
        TextButton(
          onPressed: () {
            NewStoryViewModel newStoryViewModel=Get.find();
            if(newStoryViewModel.selectedImg.value.isEmpty){
              CommanWidget.snackBar(message: 'Please select min one image');
              return;
            }
            _barController.setSelectedRoute('EditStory');
          },
          child: Text(
            'Story',
            style: TextStyle(
                color: cWhite,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 23),
          ),
        ),
        InkWell(
          onTap: () async {
            NewStoryViewModel viewModel = Get.find();
            XFile file = await getImageFromCamera();
            if (file != null) {
              Uint8List uint8List = await compressFile( File(file.path));

              viewModel.addSelectedImg(uint8List);
              viewModel.addSelectedImgFile(File(file.path));
            }
          },
          child: CircleAvatar(
            backgroundColor: cWhite,
            child: Icon(
              Icons.camera_alt_outlined,
              color: cRoyalBlue,
              size: 22,
            ),
          ),
        )
      ],
    ),
  );
}
