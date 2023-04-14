// To parse this JSON data, do
//
//     final locationAndServiceResponse = locationAndServiceResponseFromJson(jsonString);

import 'dart:convert';

LocationAndServiceResponse locationAndServiceResponseFromJson(String str) =>
    LocationAndServiceResponse.fromJson(json.decode(str));

String locationAndServiceResponseToJson(LocationAndServiceResponse data) =>
    json.encode(data.toJson());

class LocationAndServiceResponse {
  LocationAndServiceResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory LocationAndServiceResponse.fromJson(Map<String, dynamic> json) =>
      LocationAndServiceResponse(
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
    this.locations,
    this.serviceType,
  });

  List<Location> locations;
  List<ServiceType> serviceType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
        serviceType: List<ServiceType>.from(
            json["service_type"].map((x) => ServiceType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "service_type": List<dynamic>.from(serviceType.map((x) => x.toJson())),
      };
}

class Location {
  Location({
    this.id,
    this.placeName,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String placeName;
  DateTime createdAt;
  DateTime updatedAt;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        placeName: json["place_name"],
        createdAt:json["created_at"]==null?null: DateTime.parse(json["created_at"]),
        updatedAt:  json["updated_at"]==null?null:DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "place_name": placeName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ServiceType {
  ServiceType({
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

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
        id: json["id"],
        serviceCategoryName: json["service_category_name"],
        image: json["image"],
        extraInfo: json["extra_info"],
        createdAt: json["created_at"]==null?null:DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"]==null?null: DateTime.parse(json["updated_at"]),
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
