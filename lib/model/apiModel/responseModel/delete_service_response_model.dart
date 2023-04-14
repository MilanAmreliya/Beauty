// To parse this JSON data, do
//
//     final deleteServiceResponse = deleteServiceResponseFromJson(jsonString);

import 'dart:convert';

DeleteServiceResponse deleteServiceResponseFromJson(String str) =>
    DeleteServiceResponse.fromJson(json.decode(str));

String deleteServiceResponseToJson(DeleteServiceResponse data) =>
    json.encode(data.toJson());

class DeleteServiceResponse {
  DeleteServiceResponse({
    this.success,
    this.message,
  });

  bool success;
  String message;

  factory DeleteServiceResponse.fromJson(Map<String, dynamic> json) =>
      DeleteServiceResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
