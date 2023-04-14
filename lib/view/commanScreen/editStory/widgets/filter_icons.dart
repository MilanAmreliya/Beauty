import 'dart:io';
import 'dart:typed_data';

import 'package:beuty_app/comman/color_filter_image.dart';
import 'package:beuty_app/comman/crop_image.dart';
import 'package:beuty_app/view/imageBrightnees/image_brightnees.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Padding filterIcons(File file, int index) {
  return Padding(
    padding: const EdgeInsets.only(top: 30, bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        'assets/image/crop.png',
        'assets/image/brightness.png',
        // 'assets/image/sort.png',
        'assets/image/filter.png',
        // 'assets/image/More.png'
      ]
          .map(
            (e) => InkWell(
              onTap: () {
                onTap(
                  e,
                  file,
                  index,
                );
              },
              child: Image(
                image: AssetImage(e),
                height: Get.height * 0.025,
                width: Get.height * 0.025,
              ),
            ),
          )
          .toList(),
    ),
  );
}

Future<void> onTap(String img, File file, int index) async {
  if (img == 'assets/image/crop.png') {
    cropImage(img: file, index: index);
  } else if (img == 'assets/image/filter.png') {
    colorFilterImage(img: file, index: index);
  } else if (img == 'assets/image/brightness.png') {
    brightnessFilter(img: file, index: index);
  }
}

Future<void> brightnessFilter({File img, int index}) async {
  File file = await Get.to(EditPhotoScreen(arguments: [img]));
  if (file != null) {
    NewStoryViewModel viewModel = Get.find();
    Uint8List unit = file.readAsBytesSync();
    viewModel.updateSelectedImg(unit, index);
    viewModel.updateSelectedImgFile(file, index);
  }
}
