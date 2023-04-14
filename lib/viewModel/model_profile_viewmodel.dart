import 'package:beuty_app/model/apiModel/responseModel/following_followers_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/modal_like_feed.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/model/repo/get_following_followers_repo.dart';
import 'package:beuty_app/model/repo/modal_like_feed.dart';
import 'package:get/get.dart';

class ModelProfileViewModel extends GetxController {
  ApiResponse followingFollowersApiResponse = ApiResponse.initial('initial');
  ApiResponse modalLikedFeedApiResponse = ApiResponse.initial('initial');

  ///Get following followers
  Future<void> getFollowingFollowers(String artistId) async {
    followingFollowersApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      FollowingFollowersResponse response =
          await GetFollowingFollowersRepo().getAllFollowingFollowers(artistId);
      print('followingFollowersApiResponse => $response');
      followingFollowersApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("followingFollowersApiResponse.........>$e");
      followingFollowersApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///modal_like_feed...
  Future<void> modelLikedFeed() async {
    modalLikedFeedApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ModelLikedFeedResponse response =
          await ModelLikedFeedRepo().modelLikedFeedRepo();
      modalLikedFeedApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("appointmentByArtistCurrentApiResponse .........>$e");
      modalLikedFeedApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
