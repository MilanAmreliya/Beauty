import 'package:beuty_app/comman/favorite.dart';
import 'package:beuty_app/dialogs/serviceItemDialog.dart';
import 'package:beuty_app/model/apiModel/requestModel/selected_service_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/check_isliked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/serviceby_category_reponse_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:beuty_app/viewModel/get_category_viewModel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common_octo_image.dart';
import 'loading_indicator.dart';

Widget hairItemsList() {
  return Container(
      height: Get.height / 2,
      child: GetBuilder<GetCategoryViewModel>(
        builder: (controller) {
          if (controller.serviceByCategoryApiResponse.status ==
              Status.COMPLETE) {
            ServiceByCategoryResponse response =
                controller.serviceByCategoryApiResponse.data;

            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(35),
                  )),
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<GetCategoryViewModel>(
                    builder: (controller) {
                      return Text(
                        controller.currentIndex.value,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  response.data.isEmpty
                      ? Expanded(
                          child: Center(
                          child: Text('Service not available'),
                        ))
                      : Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.height * 0.02),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: BouncingScrollPhysics(),
                              itemCount: response.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      onTap(response, index);
                                    },
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            color: Colors.grey.withOpacity(0.3),
                                            height: Get.height * 0.3,
                                            width: Get.width,
                                            child: response.data[index].image ==
                                                        null ||
                                                    response.data[index]
                                                            .image ==
                                                        ''
                                                ? imageNotFound()
                                                : commonOctoImage(
                                                    image: response
                                                        .data[index].image,
                                                    height: Get.height * 0.1,
                                                    width: Get.height * 0.1,
                                                    circleShape: false,
                                                    fit: true),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 20,
                                          left: 20,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                response.data[index].serviceName
                                                        ?.capitalizeFirst ??
                                                    '',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                '\$' +
                                                        response.data[index]
                                                            .price.toString() ??
                                                    '0',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            /*child: Container(
                          child: GridView.builder(
                              itemCount: response.data.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: Get.height * 0.015,
                                childAspectRatio: 2 / 3,
                                crossAxisSpacing: Get.height * 0.015,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    onTap(response, index);
                                  },
                                  child: shopServiceStackProductBox(
                                      img: response.data[index].image,
                                      price:
                                          "${response.data[index].price ?? ""}\$",
                                      serviceName:
                                          response.data[index].serviceName ??
                                              '',
                                      serviceCat: ''),
                                );
                              })),*/
                          ),
                        ),
                ],
              ),
            );
          }
          if (controller.serviceByCategoryApiResponse.status == Status.ERROR) {
            return Center(child: Text("Server Error"));
          }
          return Center(child: circularIndicator());
        },
      ));
}

Future<void> onTap(ServiceByCategoryResponse response, int index) async {
  SelectedServiceModel _serviceModel = SelectedServiceModel();

  CommentAndLikePostViewModel likeViewModel = Get.find();
  await likeViewModel.getCheckPostLiked(
    response.data[index].id.toString(),
  );

  bool likeStatus = false;
  bool favoriteStatus = false;
  if (likeViewModel.checkIsLikedApiResponse.status == Status.COMPLETE) {
    CheckIsLikedResponse likeRes = likeViewModel.checkIsLikedApiResponse.data;
    likeStatus = likeRes.data.liked;
  }
  ValidationViewModel validationViewModel = Get.find();
  favoriteStatus = checkFavorite(response.data[index].id.toString());
  String role = validationViewModel.selectRole.value;

  response.data.forEach((element) {
    if (element.id == response.data[index].id) {
      _serviceModel.price = element.price;
      _serviceModel.image = element.image;
      _serviceModel.id = element.id.toString();
      _serviceModel.endTime = element.endTime;
      _serviceModel.startTime = element.startTime;
      _serviceModel.description = element.description;
      _serviceModel.artistId = element.artistId.toString();
    }
  });
  serviceItemDialog(
      isOnTap: role == 'Artist' ? false : true,
      rating: response.data[index].serviceRating?.toDouble() ?? 0.0,
      likeStatus: likeStatus,
      isFavorite: favoriteStatus,
      postId: response.data[index].id.toString(),
      serviceCategoryName: response.data[index].serviceName,
      image: response.data[index].image,
      description: response.data[index].description,
      price: response.data[index].price,
      serviceName: response.data[index].serviceName);
}
