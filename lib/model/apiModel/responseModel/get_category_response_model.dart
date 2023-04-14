// To parse this JSON data, do
//
//     final getCategoryResponse = getCategoryResponseFromJson(jsonString);

import 'dart:convert';

GetCategoryResponse getCategoryResponseFromJson(String str) =>
    GetCategoryResponse.fromJson(json.decode(str));

String getCategoryResponseToJson(GetCategoryResponse data) =>
    json.encode(data.toJson());

class GetCategoryResponse {
  GetCategoryResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory GetCategoryResponse.fromJson(Map<String, dynamic> json) =>
      GetCategoryResponse(
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        serviceCategoryName: json["service_category_name"],
        image: json["image"],
        extraInfo: json["extra_info"],
        createdAt: json["created_at"]==null?null:DateTime.parse(json["created_at"]),
        updatedAt:  json["updated_at"]==null?null:DateTime.parse(json["updated_at"]),
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
