// To parse this JSON data, do
//
//     final updateProfileImageResponse = updateProfileImageResponseFromJson(jsonString);

import 'dart:convert';

UpdateProfileImageResponse updateProfileImageResponseFromJson(String str) =>
    UpdateProfileImageResponse.fromJson(json.decode(str));

String updateProfileImageResponseToJson(UpdateProfileImageResponse data) =>
    json.encode(data.toJson());

class UpdateProfileImageResponse {
  UpdateProfileImageResponse({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory UpdateProfileImageResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfileImageResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
