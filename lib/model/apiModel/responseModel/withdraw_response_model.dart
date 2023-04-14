// To parse this JSON data, do
//
//     final withdrawMoneyResponse = withdrawMoneyResponseFromJson(jsonString);

import 'dart:convert';

WithdrawMoneyResponse withdrawMoneyResponseFromJson(String str) =>
    WithdrawMoneyResponse.fromJson(json.decode(str));

String withdrawMoneyResponseToJson(WithdrawMoneyResponse data) =>
    json.encode(data.toJson());

class WithdrawMoneyResponse {
  WithdrawMoneyResponse({
    this.success,
    this.message,
  });

  bool success;
  String message;

  factory WithdrawMoneyResponse.fromJson(Map<String, dynamic> json) =>
      WithdrawMoneyResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
