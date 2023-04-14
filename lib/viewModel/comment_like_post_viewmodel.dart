
import 'package:beuty_app/model/apiModel/requestModel/add_rating_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/create_comment_post_request.dart';
import 'package:beuty_app/model/apiModel/requestModel/isfavorite_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/likepost_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/add_rating_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/check_isliked_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/model/repo/add_rating_repo.dart';
import 'package:beuty_app/model/repo/check_isliked_repo.dart';
import 'package:beuty_app/model/repo/create_comment_post_repo.dart';
import 'package:beuty_app/model/repo/isfavorite_post_repo.dart';
import 'package:beuty_app/model/repo/isliked_post_repo.dart';
import 'package:get/get.dart';

class CommentAndLikePostViewModel extends GetxController {
  ApiResponse apiResponse = ApiResponse.initial('Initial');
  ApiResponse isLikeApiResponse = ApiResponse.initial('Initial');
  ApiResponse isFavoriteApiResponse = ApiResponse.initial('Initial');
  ApiResponse checkIsLikedApiResponse = ApiResponse.initial('Initial');
  ApiResponse addRatingApiResponse = ApiResponse.initial('Initial');

  RxBool _isLiked = false.obs;

  RxBool get isLiked => _isLiked;

  void setIsLiked(bool value) {
    _isLiked = value.obs;
  }

  ///post comment..
  Future<void> createComment(CreateCommentPostReq model) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response =
          await CreateCommentPostRepo().createCommentPost(model);
      apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('error.....$e');
      apiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// post like..
  Future<void> isLike(IsLikedPostReq model) async {
    isLikeApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response =
          await IsLikedPostRepo().isLikedPostRepo(model);
      isLikeApiResponse = ApiResponse.complete(response);
      print("response==>..$response");
    } catch (e) {
      print('error.....$e');
      isLikeApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// post Favorite..
  Future<void> isFavorite(IsFavoriteReq model) async {
    isFavoriteApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response =
          await IsFavoritePostRepo().isFavorite(model);
      isFavoriteApiResponse = ApiResponse.complete(response);
      print("isFavoriteApiResponse response==>..$response");
    } catch (e) {
      print('isFavoriteApiResponse error.....$e');
      isFavoriteApiResponse = ApiResponse.error('error');
    }
    update();
  }

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

  ///add rating..
  Future<void> addRating(AddRateReqModel model) async {
    addRatingApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      AddRatingResponse response = await AddRatingRepo().addRatingRepo(model);
      addRatingApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('error.....$e');
      addRatingApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
