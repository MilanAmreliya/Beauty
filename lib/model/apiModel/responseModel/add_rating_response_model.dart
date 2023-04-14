// To parse this JSON data, do
//
//     final addRatingResponse = addRatingResponseFromJson(jsonString);

import 'dart:convert';

AddRatingResponse addRatingResponseFromJson(String str) =>
    AddRatingResponse.fromJson(json.decode(str));

String addRatingResponseToJson(AddRatingResponse data) =>
    json.encode(data.toJson());

class AddRatingResponse {
  AddRatingResponse({
    this.message,
    this.data,
  });

  String message;
  Data data;

  factory AddRatingResponse.fromJson(Map<String, dynamic> json) =>
      AddRatingResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.artistId,
    this.serviceId,
    this.reviewerId,
    this.rating,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String artistId;
  String serviceId;
  String reviewerId;
  String rating;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        artistId: json["artist_id"],
        serviceId: json["service_id"],
        reviewerId: json["reviewer_id"],
        rating: json["rating"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "artist_id": artistId,
        "service_id": serviceId,
        "reviewer_id": reviewerId,
        "rating": rating,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
