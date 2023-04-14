import 'package:dio/dio.dart' as dio;

class UpdateProfileImageReqModel {
  String image;

  UpdateProfileImageReqModel({
    this.image,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      'profile_pic': await dio.MultipartFile.fromFile(image),
    };
  }
}
