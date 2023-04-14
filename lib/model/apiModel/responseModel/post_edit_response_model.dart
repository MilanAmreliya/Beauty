// To parse this JSON data, do
//
//     final postEditResponse = postEditResponseFromJson(jsonString);

import 'dart:convert';

PostEditResponse postEditResponseFromJson(String str) =>
    PostEditResponse.fromJson(json.decode(str));

String postEditResponseToJson(PostEditResponse data) =>
    json.encode(data.toJson());

class PostEditResponse {
  PostEditResponse({
    this.success,
    this.message,
  });

  bool success;
  String message;

  factory PostEditResponse.fromJson(Map<String, dynamic> json) =>
      PostEditResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
