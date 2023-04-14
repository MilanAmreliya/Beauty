
import 'package:beuty_app/model/apiModel/responseModel/check_isliked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_tags_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/model/repo/check_isliked_repo.dart';
import 'package:beuty_app/model/repo/get_tags_repo.dart';
import 'package:get/get.dart';

class GetAllTagsViewModel extends GetxController {
  RxString currentTag = ''.obs;
  void onChange(String value) {
    currentTag = value.obs;
    update();
  }

  ApiResponse apiResponse = ApiResponse.initial('Initial');

  ///getAllTags...
  Future<void> getAllTag() async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      GetTagsResponse response = await GetTagsRepo().getTagsRepo();
      if (response.data.length > 0) {
        currentTag = response.data[0].tagName.obs;
      }
      apiResponse = ApiResponse.complete(response);
      print("responsetag......>$response");
    } catch (e) {
      print("responsetag .......sd..>$e");
      apiResponse = ApiResponse.error('error');
    }
    update();
  }

  ApiResponse checkIsLikedApiResponse = ApiResponse.initial('Initial');

  ///check post liked ...
  Future<void> getCheckPostLiked(
    String postId,
  ) async {
    checkIsLikedApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      CheckIsLikedResponse response = await CheckIsLikedRepo().checkIsLiked(
        postId,
      );
      checkIsLikedApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("checkIsLikedApiResponse.........>$e");
      checkIsLikedApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
