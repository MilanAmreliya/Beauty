import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Expanded selectedImg() {
  return Expanded(
    child: GetBuilder<NewStoryViewModel>(
      builder: (controller) {
        if (controller.selectedImg.value.isEmpty) {
          return Center(child: Text('Please select Image'));
        }
        return GridView.builder(
          itemCount: controller.selectedImg.value.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: MemoryImage(controller.selectedImg.value[index]),
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    ),
  );
}
