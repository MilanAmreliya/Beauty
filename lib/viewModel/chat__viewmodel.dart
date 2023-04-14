import 'package:beuty_app/model/apiModel/responseModel/following_followers_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/shop_sales_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/model/repo/get_following_followers_repo.dart';
import 'package:beuty_app/model/repo/shop_sales_repo.dart';
import 'package:get/get.dart';

class ChatViewModel extends GetxController {
  ApiResponse shopSalesApiResponse = ApiResponse.initial('initial');

  ///get all artist
  Future<void> shopSales() async {
    shopSalesApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ShopSalesResponse response = await ShopSalesRepo().shopSales();
      shopSalesApiResponse = ApiResponse.complete(response);
      print("shopSalesApiResponse.........>$response");
    } catch (e) {
      print("shopSalesApiResponse Error.........>$e");
      shopSalesApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ApiResponse followingFollowersApiResponse = ApiResponse.initial('initial');

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

  RxString _searchStr = ''.obs;

  RxString get searchStr => _searchStr;

  void setSearchStr(String value) {
    _searchStr = value.obs;
    update();
  }

  void clearSearchStr() {
    _searchStr = ''.obs;
    update();
  }
}
