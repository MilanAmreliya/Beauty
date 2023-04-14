// To parse this JSON data, do
//
//     final getPlaceResponse = getPlaceResponseFromJson(jsonString);

import 'dart:convert';

GetPlaceResponse getPlaceResponseFromJson(String str) => GetPlaceResponse.fromJson(json.decode(str));

String getPlaceResponseToJson(GetPlaceResponse data) => json.encode(data.toJson());

class GetPlaceResponse {
  GetPlaceResponse({
    this.success,
    this.data,
  });

  bool success;
  List<PlaceDatum> data;

  factory GetPlaceResponse.fromJson(Map<String, dynamic> json) => GetPlaceResponse(
    success: json["success"],
    data: List<PlaceDatum>.from(json["data"].map((x) => PlaceDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PlaceDatum {
  PlaceDatum({
    this.id,
    this.placeName,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String placeName;
  DateTime createdAt;
  DateTime updatedAt;

  factory PlaceDatum.fromJson(Map<String, dynamic> json) => PlaceDatum(
    id: json["id"],
    placeName: json["place_name"],
    createdAt: json["created_at"]==null?null:DateTime.parse(json["created_at"]),
    updatedAt:  json["updated_at"]==null?null:DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "place_name": placeName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
