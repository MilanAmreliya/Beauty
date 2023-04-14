// To parse this JSON data, do
//
//     final getServiceResponse = getServiceResponseFromJson(jsonString);

import 'dart:convert';

GetServiceResponse getServiceResponseFromJson(String str) =>
    GetServiceResponse.fromJson(json.decode(str));

String getServiceResponseToJson(GetServiceResponse data) =>
    json.encode(data.toJson());

class GetServiceResponse {
  GetServiceResponse({
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
    this.rating,
  });

  int id;
  String serviceName;
  String image;
  int serviceCategoryId;
  dynamic price;
  int artistId;
  dynamic tags;
  int shopId;
  String startTime;
  String endTime;
  String description;
  dynamic status;
  String createdAt;
  String updatedAt;
  dynamic serviceRating;
  int rating;

  factory GetServiceResponse.fromJson(Map<String, dynamic> json) =>
      GetServiceResponse(
        id: json["id"],
        serviceName: json["service_name"],
        image: json["image"],
        serviceCategoryId: json["serviceCategory_id"],
        price: json["price"],
        artistId: json["artist_id"],
        tags: json["tags"],
        shopId: json["shop_id"],
        startTime: json["start_time"] ?? '',
        endTime: json["end_time"] ?? '',
        description: json["description"],
        status: json["status"],
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
        serviceRating: json["service_rating"],
        rating: json["rating"],
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
        "created_at": createdAt,
        "updated_at": updatedAt,
        "service_rating": serviceRating,
        "rating": rating,
      };
}
