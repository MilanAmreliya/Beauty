// To parse this JSON data, do
//
//     final checkIsLikedResponse = checkIsLikedResponseFromJson(jsonString);

import 'dart:convert';

CheckIsLikedResponse checkIsLikedResponseFromJson(String str) => CheckIsLikedResponse.fromJson(json.decode(str));

String checkIsLikedResponseToJson(CheckIsLikedResponse data) => json.encode(data.toJson());

class CheckIsLikedResponse {
  CheckIsLikedResponse({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory CheckIsLikedResponse.fromJson(Map<String, dynamic> json) => CheckIsLikedResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.liked,
    this.favourite,
  });

  bool liked;
  bool favourite;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    liked: json["liked"],
    favourite: json["favourite"],
  );

  Map<String, dynamic> toJson() => {
    "liked": liked,
    "favourite": favourite,
  };
}
