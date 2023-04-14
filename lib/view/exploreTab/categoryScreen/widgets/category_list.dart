import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_category_response_model.dart';
import 'package:beuty_app/viewModel/get_category_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../../model/apis/api_response.dart';

GetCategoryViewModel getCategoryViewModel = Get.find();

Container topHeader({Function onTap}) {
  return Container(
    width: Get.width,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Category",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: Get.height * 0.027),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: GetBuilder<GetCategoryViewModel>(
                builder: (controller) {
                  if (controller.apiResponse.status != Status.COMPLETE) {
                    return Center(child: circularIndicator());
                  }
                  if (controller.apiResponse.status == Status.ERROR) {
                    return Center(child: Text("Server Error"));
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        (controller.apiResponse.data as GetCategoryResponse)
                            .data
                            .length,
                        (index) => Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 0 : 10),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    Datum categoryId =
                                        controller.apiResponse.data.data[index];
                                    print(categoryId);
                                    onTap(categoryId.serviceCategoryName);
                                    await controller
                                        .serviceByCategory(" ${categoryId.id}");
                                  },
                                  child: Container(
                                    height: Get.height * 0.1,
                                    width: Get.width * 0.19,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 2,
                                            color: getCategoryViewModel
                                                        .currentIndex.value ==
                                                    controller
                                                        .apiResponse
                                                        .data
                                                        .data[index]
                                                        .serviceCategoryName
                                                ? Colors.blue
                                                : Colors.white)),
                                    child: (controller.apiResponse.data
                                                    as GetCategoryResponse)
                                                .data[index]
                                                .image ==
                                            null
                                        ? imageNotFound()
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: commonOctoImage(
                                                image: (controller
                                                            .apiResponse.data
                                                        as GetCategoryResponse)
                                                    .data[index]
                                                    .image,
                                                height: Get.height * 0.1,
                                                width: Get.width * 0.19,
                                                circleShape: false,
                                                fit: true
                                                /*  height: Get.height * 0.07,
                                            width: Get.height * 0.07,*/
                                                ),
                                          ),
                                  ),
                                ),
                                Text(
                                  "${(controller.apiResponse.data.data[index] as Datum).serviceCategoryName}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Get.height * 0.017,
                                      color: getCategoryViewModel
                                                  .currentIndex.value ==
                                              controller
                                                  .apiResponse
                                                  .data
                                                  .data[index]
                                                  .serviceCategoryName
                                          ? Colors.blue
                                          : Colors.black),
                                )
                              ],
                            ))),
                  );
                },
              )),
        ],
      ),
    ),
  );
}
