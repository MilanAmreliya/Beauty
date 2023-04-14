// To parse this JSON data, do
//
//     final serviceByShopResponse = serviceByShopResponseFromJson(jsonString);

import 'dart:convert';

ServiceByShopResponse serviceByShopResponseFromJson(String str) =>
    ServiceByShopResponse.fromJson(json.decode(str));

String serviceByShopResponseToJson(ServiceByShopResponse data) =>
    json.encode(data.toJson());

class ServiceByShopResponse {
  ServiceByShopResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<ServiceByShop> data;

  factory ServiceByShopResponse.fromJson(Map<String, dynamic> json) =>
      ServiceByShopResponse(
        success: json["success"],
        message: json["message"],
        data: List<ServiceByShop>.from(
            json["data"].map((x) => ServiceByShop.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ServiceByShop {
  ServiceByShop({
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
    this.serviceCategory,
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
  ServiceCategory serviceCategory;

  factory ServiceByShop.fromJson(Map<String, dynamic> json) => ServiceByShop(
        id: json["id"],
        serviceName: json["service_name"],
        image: json["image"],
        serviceCategoryId: json["serviceCategory_id"],
        price: json["price"],
        artistId: json["artist_id"],
        tags: json["tags"],
        shopId: json["shop_id"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        description: json["description"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        serviceRating:
            json["updated_at"] == null ? null : json["service_rating"],
        serviceCategory: ServiceCategory.fromJson(json["service_category"]),
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
        "service_category": serviceCategory.toJson(),
      };
}

class ServiceCategory {
  ServiceCategory({
    this.id,
    this.serviceCategoryName,
    this.image,
    this.extraInfo,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String serviceCategoryName;
  String image;
  String extraInfo;
  DateTime createdAt;
  DateTime updatedAt;

  factory ServiceCategory.fromJson(Map<String, dynamic> json) =>
      ServiceCategory(
        id: json["id"],
        serviceCategoryName: json["service_category_name"],
        image: json["image"],
        extraInfo: json["extra_info"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_category_name": serviceCategoryName,
        "image": image,
        "extra_info": extraInfo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
