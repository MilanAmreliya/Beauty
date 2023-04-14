import 'dart:io';
import 'dart:typed_data';

import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as imageLib;
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';

Future colorFilterImage({
  File img,
  int index
}) async {
  String fileName = basename(img.path);
  var image1 = imageLib.decodeImage(await img.readAsBytes());
  image1 = imageLib.copyResize(image1, width: 600);
  final imagefile = await Get.to(
    PhotoFilterSelector(
      title: Text("Photo Filter"),
      image: image1,
      appBarColor: Colors.black,
      filters: presetFiltersList,
      filename: fileName,

      loader: Center(child:  circularIndicator()),
      fit: BoxFit.contain,
    ),
  );

  if (imagefile != null && imagefile.containsKey('image_filtered')) {
    File file = imagefile['image_filtered'];

    NewStoryViewModel viewModel = Get.find();
    Uint8List unit = file.readAsBytesSync();
    viewModel.updateSelectedImg(unit, index);
    viewModel.updateSelectedImgFile(file, index);
    /* setState(() {
      print('type=>${imagefile['image_filtered'].runtimeType}');
      imageFile = uint8list;
      image = file;
    });*/
  }
}
