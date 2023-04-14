import 'package:dio/dio.dart' as dio;

class CreateShopReqModel {
  String img;
  String name;
  String adreess;
  String lati;
  String longi;
  String artistId;
  String aboutShop;
  String place;

  CreateShopReqModel(
      {this.img,
      this.artistId,
      this.name,
      this.aboutShop,
      this.adreess,
      this.lati,
      this.place,
      this.longi});

  Future<Map<String, dynamic>> toJson() async {
    return {
      'img': await dio.MultipartFile.fromFile(img),
      'name': name,
      'address': adreess,
      'lati': lati,
      'longi': longi,
      'artist_id': artistId,
      'place': place,
      'about_shop': aboutShop
    };
  }
}
