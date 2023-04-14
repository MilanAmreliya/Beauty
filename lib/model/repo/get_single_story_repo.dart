
import 'package:beuty_app/model/apiModel/responseModel/single_story_response_model.dart';
import 'package:beuty_app/model/services/api_service.dart';
import 'package:beuty_app/model/services/base_service.dart';

class GetSingleStoryRepo extends BaseService {
  Future<dynamic> getSingleStory(int id,String artistId) async {

    print('id:$id artisId:$artistId');
    var response = await ApiService()
        .getResponse(apiType: APIType.aGet, url: allArtistStoryURL + '/$artistId/$id');
    SingleStoryResponse result = SingleStoryResponse.fromJson(response);

    return result;
  }
}
