import 'package:beuty_app/model/apiModel/responseModel/get_tags_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class GetTagsRepo extends BaseService {
  Future<dynamic> getTagsRepo() async {
    var response =
        await ApiService().getResponse(apiType: APIType.aGet, url: getTagsURL);
    GetTagsResponse getCategory = GetTagsResponse.fromJson(response);

    return getCategory;
  }
}
