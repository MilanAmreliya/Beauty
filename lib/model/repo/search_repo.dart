
import 'package:beuty_app/model/apiModel/responseModel/search_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class SearchRepo extends BaseService {
  Future<dynamic> searchRepo(String userName) async {
    String url = searchURL + userName;
    var response =
        await ApiService().getResponse(apiType: APIType.aGet, url: url);
    print("responce=>.....$response");
    SearchResponse searchResponse = SearchResponse.fromJson(response);

    return searchResponse;
  }
}
