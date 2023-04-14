// To parse this JSON data, do
//
//     final checkShopAvailableResponse = checkShopAvailableResponseFromJson(jsonString);

import 'dart:convert';

CheckShopAvailableResponse checkShopAvailableResponseFromJson(String str) => CheckShopAvailableResponse.fromJson(json.decode(str));

String checkShopAvailableResponseToJson(CheckShopAvailableResponse data) => json.encode(data.toJson());

class CheckShopAvailableResponse {
  CheckShopAvailableResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory CheckShopAvailableResponse.fromJson(Map<String, dynamic> json) => CheckShopAvailableResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"]==null?Data():Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.img,
    this.address,
    this.lati,
    this.longi,
    this.shopRating,
    this.map,
    this.place,
    this.aboutShop,
    this.shopNo,
    this.shopServicesId,
    this.artistId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String img;
  String address;
  String lati;
  String longi;
  int shopRating;
  dynamic map;
  String place;
  String aboutShop;
  dynamic shopNo;
  dynamic shopServicesId;
  int artistId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    img: json["img"],
    address: json["address"],
    lati: json["lati"],
    longi: json["longi"],
    shopRating: json["shop_rating"],
    map: json["map"],
    place: json["place"],
    aboutShop: json["about_shop"],
    shopNo: json["shop_no"],
    shopServicesId: json["shop_services_id"],
    artistId: json["artist_id"],
    createdAt:  json["created_at"]==null?null:DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"]==null?null: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "img": img,
    "address": address,
    "lati": lati,
    "longi": longi,
    "shop_rating": shopRating,
    "map": map,
    "place": place,
    "about_shop": aboutShop,
    "shop_no": shopNo,
    "shop_services_id": shopServicesId,
    "artist_id": artistId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
