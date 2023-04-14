import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/shop_service_stack_product_box.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_tags_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/get_all_tags_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetAllTagsViewModel getAllTagsViewModel = Get.find();

Widget hairCategory() {
  return GetBuilder<GetAllTagsViewModel>(
    builder: (controller) {
      if (controller.apiResponse.status == Status.COMPLETE) {
        GetTagsResponse response = controller.apiResponse.data;
        if (response.data == null || response.data.length == 0) {
          return SizedBox();
        } else {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      response.data.length,
                      (index) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "#${response.data[index].tagName ?? " "}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: Get.height * 0.023),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BottomBarViewModel _barController =
                                          Get.find();

                                      _barController
                                          .setSelectedRoute('TaggedScreen');
                                      GetTagsResponse response =
                                          controller.apiResponse.data;
                                      getAllTagsViewModel.onChange(
                                          response.data[index].tagName);
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
                              Container(
                                height: Get.height * 0.2,
                                width: Get.width,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        response.data[index].services.length,
                                        (subIndex) => Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    BottomBarViewModel
                                                        _barController =
                                                        Get.find();

                                                    _barController
                                                        .setSelectedRoute(
                                                            'TaggedScreen');
                                                    getAllTagsViewModel
                                                        .onChange(response
                                                            .data[index]
                                                            .tagName);
                                                  },
                                                  child: SizedBox(
                                                    width: Get.height * 0.15,
                                                    child:
                                                        shopServiceStackProductBox(
                                                      img: response.data[index]
                                                          .services[0].image,
                                                      serviceCat: '',
                                                      price:
                                                          "${response.data[index].services[subIndex].price ?? ''}\$",
                                                      serviceName: response
                                                              .data[index]
                                                              .services[
                                                                  subIndex]
                                                              .serviceName ??
                                                          '',
                                                    ),
                                                  )),
                                            )),
                                  ),
                                ),
                              ),
                            ],
                          )),
                ),
              ),
            ),
          );
        }
      }
      if (controller.apiResponse.status == Status.ERROR) {
        return Center(
          child: Text('Server Error'),
        );
      }
      return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Center(child: Center(child: circularIndicator())));
    },
  );
}
