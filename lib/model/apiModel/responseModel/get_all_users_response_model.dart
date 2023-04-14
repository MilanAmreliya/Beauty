// To parse this JSON data, do
//
//     final getAllUsersResponse = getAllUsersResponseFromJson(jsonString);

import 'dart:convert';

GetAllUsersResponse getAllUsersResponseFromJson(String str) => GetAllUsersResponse.fromJson(json.decode(str));

String getAllUsersResponseToJson(GetAllUsersResponse data) => json.encode(data.toJson());

class GetAllUsersResponse {
  GetAllUsersResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory GetAllUsersResponse.fromJson(Map<String, dynamic> json) => GetAllUsersResponse(
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
    this.name,
    this.username,
    this.image,
  });

  int id;
  String name;
  String username;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "image": image,
  };
}
