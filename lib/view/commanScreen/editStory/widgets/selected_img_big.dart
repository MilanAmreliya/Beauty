import 'dart:io';
import 'dart:typed_data';

import 'package:beuty_app/comman/box_decoration.dart';
import 'package:beuty_app/comman/compress_image.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Expanded selectedImageBig({int selectedSlideIndex, Function onPageChanged}) {
  return Expanded(
    child: Container(
        width: Get.width,
        decoration: bottomRadiusDecoration(),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GetBuilder<NewStoryViewModel>(
                builder: (controller) {
                  return PageView(
                    onPageChanged: onPageChanged,
                    children: controller.selectedImg.value
                        .map((e) => Image(
                              image: MemoryImage(e),
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: 90,
                  ),
                  Spacer(),
                  GetBuilder<NewStoryViewModel>(
                    builder: (controller) {
                      return controller.selectedImg.value.length == 1
                          ? SizedBox()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                  controller.selectedImg.value.length,
                                  (index) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: CircleAvatar(
                                          radius: 2.5,
                                          backgroundColor:
                                              selectedSlideIndex == index
                                                  ? cPurple
                                                  : cDarkGrey,
                                        ),
                                      )),
                            );
                    },
                  ),
                  Spacer(),
                  Material(
                    color: Colors.transparent,
                    child: Ink(
                      decoration: gradientDecoration(),
                      child: InkWell(
                        onTap: () async {
                          print('index=>$selectedSlideIndex');
                          NewStoryViewModel viewModel = Get.find();
                          File file = viewModel
                              .selectedImgFile.value[selectedSlideIndex];
                          print('path=>${file.path}');

                          Uint8List unit = await compressFile(file);
                          viewModel.updateSelectedImgFinal(
                              unit, selectedSlideIndex);
                        },
                        borderRadius: BorderRadius.circular(35),
                        child: Container(
                          height: 19,
                          width: 60,
                          child: Center(
                            child: Text(
                              'Save',
                              style: TextStyle(color: cWhite),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
            )
          ],
        )),
  );
}
