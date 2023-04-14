import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/favorite.dart';
import 'package:beuty_app/comman/shop_service_stack_product_box.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/dialogs/serviceItemDialog.dart';
import 'package:beuty_app/model/apiModel/requestModel/selected_service_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/check_isliked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_tags_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:beuty_app/viewModel/get_all_tags_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../comman/loading_indicator.dart';
import 'widgets/top_header.dart';

class TaggedScreen extends StatelessWidget {
  GetAllTagsViewModel getAllTagsViewModel = Get.find();
  BottomBarViewModel _barController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('ExploreScreen');

        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: customAppBar(
            'Tagged',
            leadingOnTap: () {
              _barController.setSelectedRoute('ExploreScreen');
            },
            action: svgChat(),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              topHeader(onTap: (String value) {
                getAllTagsViewModel.onChange(value);
              }),
              SizedBox(
                height: 20,
              ),
              Expanded(child: GetBuilder<GetAllTagsViewModel>(
                builder: (controller) {
                  if (controller.apiResponse.status == Status.COMPLETE) {
                    GetTagsResponse response = controller.apiResponse.data;
                    List<Service> listService = [];
                    listService = response.data
                        .firstWhere((element) =>
                            element.tagName == controller.currentTag.value)
                        .services;
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(35),
                          )),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            controller.currentTag.value,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.height * 0.02),
                              child: Container(
                                  child: GridView.builder(
                                      itemCount: listService.length,
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
                                              serviceName: listService[index]
                                                      .serviceName ??
                                                  '',
                                              serviceCat: '',
                                              price:
                                                  "${listService[index].price ?? ""}\$",
                                              img: response.data[index]
                                                  .services[0].image),
                                        );
                                      })),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (controller.apiResponse.status == Status.ERROR) {
                    return Center(child: Text("Server Error"));
                  }
                  return Center(child: circularIndicator());
                },
              ))
            ],
          )),
    );
  }
}

Future<void> onTap(GetTagsResponse response, int index) async {
  SelectedServiceModel _serviceModel = SelectedServiceModel();

  response.data.forEach((element) {
    if (element.id == response.data[index].id) {
      _serviceModel.price = element.services[0].price;
      _serviceModel.image = element.services[0].image;
      _serviceModel.id = element.services[0].id.toString();
      _serviceModel.endTime = element.services[0].endTime;
      _serviceModel.startTime = element.services[0].startTime;
      _serviceModel.description = element.services[0].description;
      _serviceModel.artistId = element.services[0].artistId.toString();
    }
  });
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
  favoriteStatus = checkFavorite(response.data[index].id.toString());
  ValidationViewModel validationViewModel = Get.find();
  String role = validationViewModel.selectRole.value;
  print('fav=>$favoriteStatus like=>$likeStatus');
  serviceItemDialog(
      isOnTap: role == 'Artist' ? false : true,
      rating: response.data[index].services[0].serviceRating?.toDouble() ?? 0.0,
      likeStatus: likeStatus,
      isFavorite: favoriteStatus,
      postId: response.data[index].id.toString(),
      serviceCategoryName: response.data[index].services[0].serviceName,
      image: response.data[index].services[0].image,
      description: response.data[index].services[0].description,
      price: response.data[index].services[0].price,
      serviceName: response.data[index].services[0].serviceName);
}
