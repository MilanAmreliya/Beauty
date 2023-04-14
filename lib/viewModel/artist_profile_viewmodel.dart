
import 'package:beuty_app/model/apiModel/requestModel/add_shop_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/create_service_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/post_edit_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/promoted_shop_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/update_profile_image_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/update_profile_request_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/update_service_response_model.dart';
import 'package:beuty_app/model/apiModel/requestModel/withdraw_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/artist_profile_detail_reaponse_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/check_shop_available_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/delete_service_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_place.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_post_by_id_response.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_service_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_shopid_reponce.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_withdraws_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_edit_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/post_success_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/service_providedby_shop_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/shopbalance_responce_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/update_profile_image_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/update_profile_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/update_service_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/withdraw_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/model/repo/artist_details_repo.dart';
import 'package:beuty_app/model/repo/check_shop_available_repo.dart';
import 'package:beuty_app/model/repo/create_service_repo.dart';
import 'package:beuty_app/model/repo/create_shop_repo.dart';
import 'package:beuty_app/model/repo/delete_post_repo.dart';
import 'package:beuty_app/model/repo/delete_service_repo.dart';
import 'package:beuty_app/model/repo/delete_story_repo.dart';
import 'package:beuty_app/model/repo/get_place_repo.dart';
import 'package:beuty_app/model/repo/get_post_by_artist_repo.dart';
import 'package:beuty_app/model/repo/get_service_repo.dart';
import 'package:beuty_app/model/repo/get_shopid_repo.dart';
import 'package:beuty_app/model/repo/getwithdraws_repo.dart';
import 'package:beuty_app/model/repo/post_edit_repo.dart';
import 'package:beuty_app/model/repo/promoted_shop_repo.dart';
import 'package:beuty_app/model/repo/service_providedby_shop_repo.dart';
import 'package:beuty_app/model/repo/shop_balance_repo.dart';
import 'package:beuty_app/model/repo/update_profile_image_repo.dart';
import 'package:beuty_app/model/repo/update_profile_repo.dart';
import 'package:beuty_app/model/repo/update_service_repo.dart';
import 'package:beuty_app/model/repo/withdraw_money_repo.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:get/get.dart';

class ArtistProfileViewModel extends GetxController {
  ApiResponse apiResponse = ApiResponse.initial('Initial');
  ApiResponse artistProfileApiResponse = ApiResponse.initial('Initial');
  ApiResponse shopIdApiResponse = ApiResponse.initial('Initial');
  ApiResponse promotedApiResponse = ApiResponse.initial('Initial');
  ApiResponse postByArtistIdApiResponse = ApiResponse.initial('Initial');
  ApiResponse deletePostApiResponse = ApiResponse.initial('Initial');
  ApiResponse getWithdrawsApiResponse = ApiResponse.initial('Initial');
  ApiResponse serviceProviedByshopApiResponse = ApiResponse.initial('Initial');
  ApiResponse createWithdrawApiResponse = ApiResponse.initial('Initial');
  ApiResponse updateProfileApiResponse = ApiResponse.initial('Initial');
  ApiResponse updateProfileImageApiResponse = ApiResponse.initial('Initial');
  ApiResponse getPlaceApiResponse = ApiResponse.initial('initial');
  ApiResponse checkShopAvailableApiResponse = ApiResponse.initial('initial');
  ApiResponse getServiceApiResponse = ApiResponse.initial('initial');
  ApiResponse updateServiceApiResponse = ApiResponse.initial('initial');
  ApiResponse deleteServiceApiResponse = ApiResponse.initial('initial');
  ApiResponse deleteStoryApiResponse = ApiResponse.initial('initial');
  ApiResponse shopBalanceApiResponse = ApiResponse.initial('Initial');
  ApiResponse editPostApiResponse = ApiResponse.initial('Initial');

  RxList<GetPostDatum> _getPostDataAdd = <GetPostDatum>[].obs;

  RxList<GetPostDatum> get getPostDataAdd => _getPostDataAdd;

  void setGetPostDataAdd(GetPostDatum value) {
    _getPostDataAdd.add(value);
    update();
  }

  void clearGetPostData() {
    _getPostDataAdd.clear();
    update();
  }

  ///Create Shop..
  Future<void> createShop(CreateShopReqModel model) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response =
          await CreateShopRepo().createShopRepo(model);
      apiResponse = ApiResponse.complete(response);
      print("$response");
    } catch (e) {
      print('error.....$e');
      apiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Create Service..
  Future<void> createService(CreateServiceReqModel model) async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response =
          await CreateServiceRepo().createServiceRepo(model);
      apiResponse = ApiResponse.complete(response);
      print("$response");
    } catch (e) {
      print('error.....$e');
      apiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Get Shop Id-*

  Future<void> getShopByCreate(String artistId) async {
    shopIdApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      GetShopId response = await GetShopIdRepo().getShopIdRepo(artistId);
      print('shopIdApiResponse${response}');
      shopIdApiResponse = ApiResponse.complete(response);
      GetShopId responsee = shopIdApiResponse.data;
      await PreferenceManager.setShopId(responsee.data.id);
      var shopId = PreferenceManager.getShopId();
      print("shopId==>$shopId");
    } catch (e) {
      print("shopIdApiResponse .........>$e");
      shopIdApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Promoted Shop
  Future<void> createPromotedShop(PromotedShopRequestModel model) async {
    promotedApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response =
          await PromotedShopRepo().promotedShop(model);
      print('promotedApiResponse${response}');
      promotedApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("promotedApiResponse .........>$e");
      promotedApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Get Profile Detail
  Future<void> getProfileDetail({String artistId}) async {
    artistProfileApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ArtistProfileDetailResponse response =
          await GetArtistProfileDetailRepo().getArtistDetails(artistId);
      artistProfileApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("artistProfileApiResponse Error.........>$e");
      artistProfileApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Get Post By Artist
  Future<void> getPostByArtist() async {
    postByArtistIdApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      GetPostByIdResponse response =
          await GetPostByArtistRepo().getPostByArtist();
      print('postByArtistIdApiResponse => $response');
      postByArtistIdApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("postByArtistIdApiResponse.........>$e");
      postByArtistIdApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Delete Artist Post
  Future<void> deleteArtistPost(String postId) async {
    deletePostApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response = await DeletePostRepo().deletePost(postId);
      deletePostApiResponse = ApiResponse.complete(response);
      getPostByArtist();
    } catch (e) {
      print("deletePostApiResponse.........>$e");
      deletePostApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///shopBalance data...

  Future<void> shopBalance() async {
    shopBalanceApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ShopBalanceResponse response = await ShopBalanceRepo().shopBalanceRepo();
      shopBalanceApiResponse = ApiResponse.complete(response);
      print("shopBalanceApiResponseresponse==>$response");
    } catch (e) {
      print("shopBalanceApiResponse .........>$e");
      shopBalanceApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///getWithdraws data...

  Future<void> getWithdraws(String shopId) async {
    getWithdrawsApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      GetWithdrawResponse response =
          await GetWithdrawsRepo().getWithdrawsRepo(shopId);
      getWithdrawsApiResponse = ApiResponse.complete(response);
      print("getWithdraws response==>$response");
    } catch (e) {
      print("getWithdraws Error .........>$e");
      getWithdrawsApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///ServiceProviedByshop data...

  Future<void> serviceProviedByShop(String shopId) async {
    serviceProviedByshopApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ServiceProviedByshopResponse response =
          await ServiceProvidedByShopRepo().serviceProvidedByShopRepo(shopId);
      serviceProviedByshopApiResponse = ApiResponse.complete(response);
      print("serviceProviedByshop response==>$response");
    } catch (e) {
      print("serviceProviedByshop .........>$e");
      serviceProviedByshopApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Create withdraw..
  Future<void> withdraw(WithdrawReqModel model) async {
    createWithdrawApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      WithdrawMoneyResponse response =
          await WithdrawMoneyRepo().withdrawMoneyRepo(model);
      createWithdrawApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('createWithdrawApiResponse verror.....$e');
      createWithdrawApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///update profile
  Future<void> updateProfile(UpdateProfileReqModel model) async {
    updateProfileApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      UpdateProfileResponse response =
          await UpdateProfileRepo().updateProfileRepo(model);
      updateProfileApiResponse = ApiResponse.complete(response);
      print("$response");
    } catch (e) {
      print('error.....$e');
      updateProfileApiResponse = ApiResponse.error('error');
    }
    update();
  }

  Future<void> updateProfileImage(UpdateProfileImageReqModel model) async {
    updateProfileImageApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      UpdateProfileImageResponse response =
          await UpdateProfileImageRepo().updateProfileImageRepo(model);
      updateProfileImageApiResponse = ApiResponse.complete(response);
      print("$response");
    } catch (e) {
      print('error.....$e');
      updateProfileImageApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Get Place..
  Future<void> getPlace() async {
    getPlaceApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      GetPlaceResponse response = await GetPlaceRepo().getPlace();
      getPlaceApiResponse = ApiResponse.complete(response);
      print("getPlaceApiResponse $response");
    } catch (e) {
      print('getPlaceApiResponse error.....$e');
      getPlaceApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///Check Shop Available..
  Future<void> checkShopAvailable() async {
    checkShopAvailableApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      CheckShopAvailableResponse response =
          await CheckShopAvailableRepo().checkShopAvailable();
      checkShopAvailableApiResponse = ApiResponse.complete(response);
      if (response.message == "artist has shop") {
        await PreferenceManager.setShopId(response.data.id);

        shopBalance();
      }
      print("checkShopAvailableApiResponse $response");
    } catch (e) {
      print('checkShopAvailableApiResponse error.....$e');
      checkShopAvailableApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///get Service
  Future<void> getService(String serviceId) async {
    print('serviceId:$serviceId');
    getServiceApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      GetServiceResponse response =
          await GetServiceRepo().getServiceRepo(serviceId);
      getServiceApiResponse = ApiResponse.complete(response);
      print("getServiceApiResponse 1.........>$getServiceApiResponse");
    } catch (e) {
      print("getServiceApiResponse 2.........>$e");
      getServiceApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///update Service..
  Future<void> updateService(UpdateServiceReqModel model) async {
    updateServiceApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      UpdateServiceResponse response =
          await UpdateServiceRepo().updateServiceRepo(model);
      updateServiceApiResponse = ApiResponse.complete(response);
      print("$response");
    } catch (e) {
      print('error.....$e');
      updateServiceApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///delete Service
  Future<void> deleteService(String serviceId) async {
    deleteServiceApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      DeleteServiceResponse response =
          await DeleteServiceRepo().deleteServiceRepo(serviceId);
      deleteServiceApiResponse = ApiResponse.complete(response);
      print("deleteServiceApiResponse.........>$response");
    } catch (e) {
      print("deleteServiceApiResponse.........>$e");
      deleteServiceApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///edit post...

  Future<void> editPost(PostEditReq model, String feedId) async {
    editPostApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostEditResponse response =
          await PostEditRepo().postEditRepo(model.toJson(), feedId);
      editPostApiResponse = ApiResponse.complete(response);
      print("$response");
    } catch (e) {
      print('error.....$e');
      editPostApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///delete story...
  ///delete Service
  Future<void> deleteStory(String storyId, String userId) async {
    deleteStoryApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      PostSuccessResponse response =
          await DeleteStoryRepo().deleteStoryRepo(storyId, userId);
      deleteStoryApiResponse = ApiResponse.complete(response);
      print("deleteStoryApiResponse.........>$response");
    } catch (e) {
      print("deleteStoryApiResponse.........>$e");
      deleteStoryApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
