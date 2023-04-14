
import 'package:beuty_app/model/apiModel/responseModel/get_category_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class GetCategoryRepo extends BaseService {
  Future<dynamic> getCategoryRepo() async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aGet, url: getCategoryURL);
    GetCategoryResponse getCategory = GetCategoryResponse.fromJson(response);

    return getCategory;
  }
}
