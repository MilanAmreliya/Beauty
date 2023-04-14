import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:beuty_app/model/apiModel/requestModel/story_comment_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/story_like_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_artist_allstory_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/single_story_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/model/repo/get_artist_allstory_repo.dart';
import 'package:beuty_app/model/repo/get_single_story_repo.dart';
import 'package:beuty_app/model/repo/story_comment_repo.dart';
import 'package:beuty_app/model/repo/story_like_repo.dart';
import 'package:get/get.dart';

class NewStoryViewModel extends GetxController {
  RxList<Uint8List> _selectedImg = <Uint8List>[].obs;
  RxList<Uint8List> _selectedImgFinal = <Uint8List>[].obs;

  RxList<Uint8List> get selectedImgFinal => _selectedImgFinal;

  void updateSelectedImgFinal(Uint8List value, int index) {
    _selectedImgFinal[index] = value;
    update();
  }

  RxList<Uint8List> get selectedImg => _selectedImg;

  void addSelectedImg(Uint8List value) {
    log("$value");
    _selectedImg.add(value);
    _selectedImgFinal.add(value);
    update();
  }

  void updateSelectedImg(Uint8List value, int index) {
    _selectedImg[index] = value;
    update();
  }

  RxList<File> _selectedImgFile = <File>[].obs;

  RxList<File> get selectedImgFile => _selectedImgFile;

  void addSelectedImgFile(File value) {
    _selectedImgFile.add(value);
    update();
  }

  void updateSelectedImgFile(File value, int index) {
    _selectedImgFile[index] = value;
    update();
  }

  void clearSelectedImg() {
    _selectedImg.clear();
    _selectedImgFile.clear();
    _selectedImgFinal.clear();
    update();
  }

  ApiResponse apiResponse = ApiResponse.initial('Initial');
  ApiResponse singleStoryApiResponse = ApiResponse.initial('Initial');
  ApiResponse storyCommentApiResponse = ApiResponse.initial('Initial');
  ApiResponse storyLikeApiResponse = ApiResponse.initial('Initial');

  ///getArtistAllStory...
  Future<void> getArtistAllStory({String lat, String long}) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      GetArtistAllStoryResponse response =
          await GetArtistAllStoryRepo().getArtistStory(lat: lat, long: long);
      apiResponse = ApiResponse.complete(response);
      print('getAllStory Response :$response');
    } catch (e) {
      print("getAllStory error.........>$e");
      apiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///getSingleStory...
  Future<void> getSingleStory(int id, String artistId) async {
    singleStoryApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      SingleStoryResponse response =
          await GetSingleStoryRepo().getSingleStory(id, artistId);
      singleStoryApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("singleStoryApiResponse.........>$e");
      singleStoryApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Story Comment
  Future<void> storyComment(StoryCommentRequestModel model) async {
    storyCommentApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response =
          await StoryCommentRepo().storyComment(model);
      storyCommentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("storyCommentApiResponse.........>$e");
      storyCommentApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Story Like
  Future<void> storyLike(StoryLikeRequestModel model) async {
    storyLikeApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response = await StoryLikeRepo().storyLike(model);
      storyLikeApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("storyLikeApiResponse.........>$e");
      storyLikeApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
