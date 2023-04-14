import 'package:beuty_app/res/utility.dart';
import 'package:dio/dio.dart' as dio;

class UpdateServiceReqModel {
  String serviceName;
  String image;
  String price;
  String categoryId;
  String description;
  String startFrom;
  String endAt;

  UpdateServiceReqModel({
    this.image,
    this.price,
    this.description,
    this.categoryId,
    this.startFrom,
    this.endAt,
    this.serviceName,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      'service_name': serviceName,
      // 'image': image,
      'image': Utility.isImageChange == false
          ? image
          : await dio.MultipartFile.fromFile(image),
      'price': price,
      'serviceCategory_id': categoryId,
      'description': description,
      'start_from': startFrom,
      'end_at': endAt,
    };
  }
}
