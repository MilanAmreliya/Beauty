// To parse this JSON data, do
//
//     final updateServiceResponse = updateServiceResponseFromJson(jsonString);

import 'dart:convert';

UpdateServiceResponse updateServiceResponseFromJson(String str) =>
    UpdateServiceResponse.fromJson(json.decode(str));

String updateServiceResponseToJson(UpdateServiceResponse data) =>
    json.encode(data.toJson());

class UpdateServiceResponse {
  UpdateServiceResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory UpdateServiceResponse.fromJson(Map<String, dynamic> json) =>
      UpdateServiceResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
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
    this.serviceName,
    this.image,
    this.serviceCategoryId,
    this.price,
    this.artistId,
    this.tags,
    this.shopId,
    this.startTime,
    this.endTime,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.serviceRating,
  });

  int id;
  String serviceName;
  String image;
  String serviceCategoryId;
  dynamic price;
  int artistId;
  dynamic tags;
  int shopId;
  String startTime;
  String endTime;
  String description;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic serviceRating;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        serviceName: json["service_name"],
        image: json["image"],
        serviceCategoryId: json["serviceCategory_id"],
        price: json["price"],
        artistId: json["artist_id"],
        tags: json["tags"],
        shopId: json["shop_id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        description: json["description"],
        status: json["status"],
        createdAt:json["created_at"]==null?null: DateTime.parse(json["created_at"]),
        updatedAt:  json["updated_at"]==null?null:DateTime.parse(json["updated_at"]),
        serviceRating: json["service_rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "image": image,
        "serviceCategory_id": serviceCategoryId,
        "price": price,
        "artist_id": artistId,
        "tags": tags,
        "shop_id": shopId,
        "start_time": startTime,
        "end_time": endTime,
        "description": description,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "service_rating": serviceRating,
      };
}
