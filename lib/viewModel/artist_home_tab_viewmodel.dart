import 'package:beuty_app/model/apiModel/requestModel/create_post_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/create_story_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/find_shop_by_filter_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/follow_person_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_post_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/find_shop_by_filter_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/home_screen_feed_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/search_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/service_by_shop_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/toplocationandservice_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/model/repo/create_post_repo.dart';
import 'package:beuty_app/model/repo/create_story_repo.dart';
import 'package:beuty_app/model/repo/find_shop_by_filter_repo.dart';
import 'package:beuty_app/model/repo/follow_person_repo.dart';
import 'package:beuty_app/model/repo/get_artist_post_repo.dart';
import 'package:beuty_app/model/repo/home_screen_feed_repo.dart';
import 'package:beuty_app/model/repo/location_and_service_repo.dart';
import 'package:beuty_app/model/repo/search_repo.dart';
import 'package:beuty_app/model/repo/serviceby_shop_repo.dart';
import 'package:get/get.dart';

class HomeTabViewModel extends GetxController {
  RxList<UserComment> _selectedComment = <UserComment>[].obs;

  RxList<UserComment> get selectedComment => _selectedComment;

  void setSelectedComment(List<UserComment> value) {
    _selectedComment = value.obs;
    update();
  }

  RxString _currentLocation = ''.obs;

  RxString get currentLocation => _currentLocation;

  void setCurrentLocation(String value) {
    _currentLocation = value.obs;
    update();
  }

  RxString _services = ''.obs;

  RxString get services => _services;

  void setServices(String value) {
    _services = value.obs;
    update();
  }

  RxString _serviceId = ''.obs;

  RxString get serviceId => _serviceId;

  void setServiceId(String value) {
    _serviceId = value.obs;
    print('service ID :$value');
    update();
  }

  RxString _role = ''.obs;

  RxString get role => _role;

  void setRole(String value) {
    _role = value.obs;
  }


  ApiResponse apiResponse = ApiResponse.initial('Initial');

  // ApiResponse homeArtistApiResponse = ApiResponse.initial('Initial');
  ApiResponse getHomeFeedApiResponse = ApiResponse.initial('Initial');
  ApiResponse followPersonApiResponse = ApiResponse.initial('Initial');
  ApiResponse serviceByShopApiResponse = ApiResponse.initial('Initial');
  ApiResponse artistPostApiResponse = ApiResponse.initial('Initial');
  ApiResponse searchApiResponse = ApiResponse.initial('Initial');
  ApiResponse locationAndServiceApiResponse = ApiResponse.initial('Initial');
  ApiResponse findShopByFilterApiResponse = ApiResponse.initial('Initial');

  ///create post...
  Future<void> createPost(CreatePostReqModel model) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response =
          await CreatePostRepo().createPostRepo(model);
      apiResponse = ApiResponse.complete(response);
    } catch (e) {
      apiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///create story...
  Future<void> createStory(CreateStoryReqModel model) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response =
          await CreateStoryRepo().createStoryRepo(model);
      apiResponse = ApiResponse.complete(response);
    } catch (e) {
      apiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///home artist data..
/*  Future<void> getHomeArtist() async {
    homeArtistApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      HomeArtistResponse response = await GetHomeArtistRepo().getHomeRepo();
      homeArtistApiResponse = ApiResponse.complete(response);
      print("response...>$response");
    } catch (e) {
      print("homeArtistApiResponse.........>$e");
      homeArtistApiResponse = ApiResponse.error('error');
    }
    update();
  }*/

  ///home Feed data..
  Future<void> getHomeFeed({String lat,String long}) async {
    getHomeFeedApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      HomeScreenFeedResponse response =
          await GetHomeScreenFeedRepo().getHomeScreenFeed(lat: lat,long: long);
      getHomeFeedApiResponse = ApiResponse.complete(response);
      print("getHomeFeedApiResponse...>$response");
    } catch (e) {
      print("getHomeFeedApiResponse Error.........>$e");
      getHomeFeedApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///follow person..
  Future<void> createFollowPerson(FollowPersonRequestModel model) async {
    followPersonApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response =
          await FollowPersonRepo().followPerson(model);
      followPersonApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("followPersonApiResponse.........>$e");
      followPersonApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///shopByArtist data...
  Future<void> serviceByShop() async {
    serviceByShopApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ServiceByShopResponse response =
          await ServiceByShopRepo().serviceByShopRepo();
      serviceByShopApiResponse = ApiResponse.complete(response);
      print("serviceByShopApiResponseresponse==>$response");
    } catch (e) {
      print("......dc...>$e");
      serviceByShopApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Get Artist Posts...
  Future<void> getArtistPost(String artistId) async {
    artistPostApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ArtistPostResponse response =
          await GetArtistPostRepo().getArtistPost(artistId);
      artistPostApiResponse = ApiResponse.complete(response);
      print('artistPostApiResponse : $response');
    } catch (e) {
      print("artistPostApiResponse.........>$e");
      artistPostApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///search..
  Future<void> searchModalArtist(String userName) async {
    searchApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      SearchResponse response = await SearchRepo().searchRepo(userName);
      searchApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("searchApiResponse.........>$e");
      searchApiResponse = ApiResponse.error('error');
    }
    update();
  }

  // RxList<LocationAndServiceResponse> _locationData =
  //     <LocationAndServiceResponse>[].obs;
  //
  // RxList get locationData => _locationData;
  //
  // void setLocationData(RxList value) {
  //   _locationData = value;
  // }

  ///locationAndServiceResponse....
  Future<void> locationAndService() async {
    locationAndServiceApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      LocationAndServiceResponse response =
          await LocationAndServiceRepo().locationAndServiceRepo();

      locationAndServiceApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("locationAndServiceApiResponse.........>$e");
      locationAndServiceApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///FindShopByFilter...
  Future<void> findShopByFilter(FindShopByFilterReqModel model) async {
    findShopByFilterApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      HomeScreenFeedResponse response =
          await FindShopByFilterRepo().findShopByFilterRepo(model);
      findShopByFilterApiResponse = ApiResponse.complete(response);
      print("FindShopByFilterRes......>$response");
    } catch (e) {
      print('FindShopByFilterRes Error :$e');
      findShopByFilterApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
