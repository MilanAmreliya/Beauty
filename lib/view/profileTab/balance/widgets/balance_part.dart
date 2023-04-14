import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/responseModel/service_providedby_shop_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

SingleChildScrollView balancePage() {
  return SingleChildScrollView(
    child: GetBuilder<ArtistProfileViewModel>(
      builder: (controller) {
        if (controller.serviceProviedByshopApiResponse.status !=
            Status.COMPLETE) {
          return Center(child: circularIndicator());
        }
        if (controller.serviceProviedByshopApiResponse.status == Status.ERROR) {
          return Center(child: Text("Server Error"));
        }

        ServiceProviedByshopResponse response =
            controller.serviceProviedByshopApiResponse.data;
        if (response.data.length <= 0) {
          return Center(
              child: Padding(
            padding: EdgeInsets.only(top: Get.height * 0.2),
            child: Text("No balance Data"),
          ));
        }
        return Column(
          children: List.generate(
            response.data.length,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.height * 0.023),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      BottomBarViewModel _barController = Get.find();
                      _barController.setSelectedRoute('HairCut');
                    },
                    child: Container(
                      height: Get.height * 0.1,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 5)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: Get.height * 0.01,
                            left: Get.height * 0.01,
                            top: Get.height * 0.01,
                            bottom: Get.height * 0.01),
                        child: Row(
                          children: [
                            //DK

                            response.data[index].image == null ||
                                    response.data[index].image == ''
                                ? imageNotFound()
                                : ClipOval(
                                    child: commonProfileOctoImage(
                                      image: response.data[index].image,
                                      height: Get.height * 0.07,
                                      width: Get.height * 0.07,
                                    ),
                                  ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    response.data[index].serviceName ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: Get.height * 0.016,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins"),
                                  ),
                                  Text(
                                    response.data[index].serviceCategoryName ??
                                        '',
                                    style: TextStyle(
                                        fontSize: Get.height * 0.014,
                                        fontFamily: "Poppins"),
                                  )
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   width: Get.width * 0.12,
                            // ),
                            Expanded(
                              child: Text(
                                "\$${response.data[index].ammount ?? ""}",
                                style: TextStyle(
                                    fontSize: Get.height * 0.023,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins"),
                              ),
                            ),
                            // SizedBox(
                            //   width: Get.width * 0.11,
                            // ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${DateFormat('dd.MM.yy').format(response.data[index].createdAt)}",
                                    style: TextStyle(
                                        fontSize: Get.height * 0.016,
                                        fontFamily: "Poppins"),
                                  ),
                                  Text(
                                    "${DateFormat.jm().format(response.data[index].createdAt)}",
                                    style: TextStyle(
                                        fontSize: Get.height * 0.016,
                                        fontFamily: "Poppins"),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
