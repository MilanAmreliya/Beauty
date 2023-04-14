
import 'dart:convert';

PostSuccessResponse postSuccessResponseFromJson(String str) => PostSuccessResponse.fromJson(json.decode(str));

String postSuccessResponseToJson(PostSuccessResponse data) => json.encode(data.toJson());

class PostSuccessResponse {
  PostSuccessResponse({
    this.success,
    this.message,
  });

  bool success;
  String message;

  factory PostSuccessResponse.fromJson(Map<String, dynamic> json) => PostSuccessResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
