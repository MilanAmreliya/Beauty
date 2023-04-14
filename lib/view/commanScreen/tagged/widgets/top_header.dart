import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_tags_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/get_all_tags_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SingleChildScrollView topHeader({Function onTap}) {
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GetBuilder<GetAllTagsViewModel>(
        builder: (controller) {
          if (controller.apiResponse.status == Status.COMPLETE) {
            GetTagsResponse response = controller.apiResponse.data;
            return Row(
              children: List.generate(
                response.data.length,
                (index) => Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            onTap(response.data[index].tagName);
                          },
                          child: Container(
                            height: Get.height * 0.04,
                            // width: Get.width * 0.19,
                            decoration: BoxDecoration(
                                color: cWhite,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    width: 2,
                                    color: controller.currentTag.value ==
                                            response.data[index].tagName
                                        ? Colors.blue
                                        : Colors.white)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.height * 0.025),
                              child: Center(
                                child: Text(
                                  "#${response.data[index].tagName}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Get.height * 0.02,
                                      color: controller.currentTag.value ==
                                              response.data[index].tagName
                                          ? Colors.blue
                                          : Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            );
          }
          if (controller.apiResponse.status == Status.ERROR) {
            return Center(child: Text("Server Error"));
          }
          return circularIndicator();
        },
      ));
}
