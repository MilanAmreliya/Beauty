// To parse this JSON data, do
//
//     final completeAppointmentResponse = completeAppointmentResponseFromJson(jsonString);

import 'dart:convert';

CompleteAppointmentResponse completeAppointmentResponseFromJson(String str) => CompleteAppointmentResponse.fromJson(json.decode(str));

String completeAppointmentResponseToJson(CompleteAppointmentResponse data) => json.encode(data.toJson());

class CompleteAppointmentResponse {
  CompleteAppointmentResponse({
    this.success,
    this.message,
    this.revenue,
    this.shopBalance,
  });

  bool success;
  String message;
  int revenue;
  int shopBalance;

  factory CompleteAppointmentResponse.fromJson(Map<String, dynamic> json) => CompleteAppointmentResponse(
    success: json["success"],
    message: json["message"],
    revenue: json["revenue"],
    shopBalance: json["shop_balance"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "revenue": revenue,
    "shop_balance": shopBalance,
  };
}
