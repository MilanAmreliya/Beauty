import 'dart:io';
import 'dart:typed_data';

import 'package:beuty_app/comman/compress_image.dart';
import 'package:beuty_app/comman/get_image_picker.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Row headerFirst() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Gallery',
      ),
      Icon(Icons.keyboard_arrow_down),
      Spacer(),
      Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: cLightGrey)),
          child: InkWell(
            onTap: () async {
              NewStoryViewModel viewModel = Get.find();
              XFile file = await getImageFromGallery();
              if (file != null) {
                Uint8List uint8List = await compressFile(File(file.path));

                viewModel.addSelectedImg(uint8List);
                viewModel.addSelectedImgFile(File(file.path));

                print('path=>${file.path}');
              }
            },
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 25,
              width: 120,
              child: Center(
                  child: Text(
                'Select Multiple',
                style: TextStyle(color: cDarkGrey),
              )),
            ),
          ),
        ),
      )
    ],
  );
}
