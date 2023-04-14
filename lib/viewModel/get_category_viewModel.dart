
import 'package:beuty_app/model/apiModel/responseModel/get_category_response_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/serviceby_category_reponse_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/model/repo/get_category_repo.dart';
import 'package:beuty_app/model/repo/serviceby_category_repo.dart';
import 'package:get/get.dart';

class GetCategoryViewModel extends GetxController {
  ApiResponse apiResponse = ApiResponse.initial('Initial');
  ApiResponse serviceByCategoryApiResponse = ApiResponse.initial('Initial');

  RxString currentIndex = ''.obs;

  void onChnage(String value) {
    currentIndex = value.obs;
    update();
  }

  ///getCategory...
  Future<void> getCategory() async {
    apiResponse = ApiResponse.loading('Loading');
    update();
    try {
      GetCategoryResponse response = await GetCategoryRepo().getCategoryRepo();
      serviceByCategory(response.data[0].id.toString());
      currentIndex = (response.data[0].serviceCategoryName).obs;
      apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("getCategory.........>$e");
      apiResponse = ApiResponse.error('error');
    }
    update();
  }


  ///serviceByCategory...
  Future<void> serviceByCategory(String categoryId) async {
    serviceByCategoryApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ServiceByCategoryResponse response =
          await ServiceByCategoryrepo().serviceByCategoryRepo(categoryId);
      serviceByCategoryApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("serviceByCategoryApiResponse.........>$e");
      serviceByCategoryApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
