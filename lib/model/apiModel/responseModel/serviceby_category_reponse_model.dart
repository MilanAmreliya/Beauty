// To parse this JSON data, do
//
//     final serviceByCategoryResponse = serviceByCategoryResponseFromJson(jsonString);

import 'dart:convert';

ServiceByCategoryResponse serviceByCategoryResponseFromJson(String str) => ServiceByCategoryResponse.fromJson(json.decode(str));

String serviceByCategoryResponseToJson(ServiceByCategoryResponse data) => json.encode(data.toJson());

class ServiceByCategoryResponse {
  ServiceByCategoryResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory ServiceByCategoryResponse.fromJson(Map<String, dynamic> json) => ServiceByCategoryResponse(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
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
  int serviceCategoryId;
  dynamic price;
  int artistId;
  dynamic tags;
  int shopId;
  DateTime startTime;
  DateTime endTime;
  String description;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic serviceRating;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    serviceName: json["service_name"],
    image: json["image"],
    serviceCategoryId: json["serviceCategory_id"],
    price: json["price"],
    artistId: json["artist_id"],
    tags: json["tags"],
    shopId: json["shop_id"],
    startTime: json["start_time"]==null?null:DateTime.parse(json["start_time"]),
    endTime:json["end_time"]==null?null: DateTime.parse(json["end_time"]),
    description: json["description"],
    status: json["status"],
    createdAt: json["created_at"]==null?null:DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"]==null?null:DateTime.parse(json["updated_at"]),
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
    "start_time": startTime.toIso8601String(),
    "end_time": endTime.toIso8601String(),
    "description": description,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "service_rating": serviceRating,
  };
}
