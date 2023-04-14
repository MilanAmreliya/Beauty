import 'dart:io';
import 'dart:typed_data';

import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

Future cropImage({File img, int index}) async {
  if (img != null) {
    final crop = await ImageCropper.cropImage(
        sourcePath: img.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxHeight: 700,
        maxWidth: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          toolbarTitle: "Crpooer",
          statusBarColor: Colors.white,
          backgroundColor: Colors.white,
        ));
    NewStoryViewModel viewModel = Get.find();
    Uint8List unit = crop.readAsBytesSync();
    viewModel.updateSelectedImg(unit, index);
    viewModel.updateSelectedImgFile(crop, index);
    print('path=>${crop.path}');
  }
}
