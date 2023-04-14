import 'package:dio/dio.dart' as dio;

class CreateServiceReqModel {
  String serviceName;
  String image;
  String price;
  String categoryId;
  String artistId;
  String shopId;
  String description;
  String startFrom;
  String endAt;
  String tags;

  CreateServiceReqModel({
    this.image,
    this.price,
    this.description,
    this.artistId,
    this.categoryId,
    this.startFrom,
    this.endAt,
    this.serviceName,
    this.shopId,
    this.tags,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      'service_name': serviceName,
      'image': await dio.MultipartFile.fromFile(image),
      'price': price,
      'category_id': categoryId,
      'shop_id': shopId,
      'artist_id': artistId,
      'description': description,
      'start_time': startFrom,
      'end_time': endAt,
      'tags': tags,
    };
  }
}
