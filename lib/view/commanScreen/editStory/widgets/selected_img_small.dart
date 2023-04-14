import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget selectedImageSmall(int selectedSlideIndex) {
  return GetBuilder<NewStoryViewModel>(
    builder: (controller) {
      return  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  controller.selectedImg.value.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          height: Get.height * 0.07,
                          width: Get.height * 0.07,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: selectedSlideIndex == index
                                    ? cWhite
                                    : Colors.transparent,
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(
                                      controller.selectedImg.value[index]))),
                        ),
                      )),
            );
    },
  );
}
