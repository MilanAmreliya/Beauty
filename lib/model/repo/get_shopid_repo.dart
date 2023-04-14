
import 'package:beuty_app/model/apiModel/responseModel/get_shopid_reponce.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class GetShopIdRepo extends BaseService {
  Future<dynamic> getShopIdRepo(String artistId) async {
    String url = getShopIdURL + artistId;
    var response =
        await ApiService().getResponse(apiType: APIType.aGet, url: url);
    print("responce=>.....$response");
    GetShopId getShopId = GetShopId.fromJson(response);

    return getShopId;
  }
}
