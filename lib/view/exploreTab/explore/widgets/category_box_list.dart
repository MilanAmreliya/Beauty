import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_category_response_model.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/get_category_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/apis/api_response.dart';

Container categoryBoxList() {
  return Container(
    height: Get.height * 0.33,
    width: Get.width,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: Get.height * 0.023),
              ),
              GestureDetector(
                onTap: () {
                  BottomBarViewModel _barController = Get.find();

                  _barController.setSelectedRoute('CategoryScreen');
                },
                child: Icon(
                  Icons.navigate_next,
                  size: Get.height * 0.03,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          GetBuilder<GetCategoryViewModel>(
            builder: (controller) {
              return Flexible(
                child: controller.apiResponse.status == Status.COMPLETE
                    ? GridView.count(
                        crossAxisCount: 4,
                        padding: EdgeInsets.zero,
                        childAspectRatio: 1 / 1.2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 10,
                        children: List.generate(
                            (controller.apiResponse.data as GetCategoryResponse)
                                .data
                                .length,
                            (index) => category_item(
                                  controller.apiResponse.data.data[index],
                                )),
                      )
                    : Center(child: circularIndicator()),
              );
            },
          )
        ],
      ),
    ),
  );
}

GetCategoryViewModel categoryViewModel = Get.find();

GestureDetector category_item(
  // Map<String, String> model,
  Datum model,
) {
  return GestureDetector(
    onTap: () {
      BottomBarViewModel _barController = Get.find();

      _barController.setSelectedRoute('CategoryScreen');
      categoryViewModel.onChnage(model.serviceCategoryName);
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /*Image.asset(
          kCategory[0]['img'],
          height: Get.height * 0.09,
        ),*/
        model.image == null || model.image == ''
            ? imageNotFound()
            : Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.grey.withOpacity(0.3),
                    child: commonOctoImage(
                        image: model.image,
                        /*height: Get.height * 0.08,
                        width: Get.height * 0.08,*/
                        circleShape: false,
                        fit: true),
                  ),
                ),
              ),
        Text(
          model.serviceCategoryName,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}
