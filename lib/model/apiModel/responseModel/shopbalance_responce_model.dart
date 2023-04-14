// To parse this JSON data, do
//
//     final shopBalanceResponse = shopBalanceResponseFromJson(jsonString);

import 'dart:convert';

ShopBalanceResponse shopBalanceResponseFromJson(String str) =>
    ShopBalanceResponse.fromJson(json.decode(str));

String shopBalanceResponseToJson(ShopBalanceResponse data) =>
    json.encode(data.toJson());

class ShopBalanceResponse {
  ShopBalanceResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory ShopBalanceResponse.fromJson(Map<String, dynamic> json) =>
      ShopBalanceResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? Data(balance: 0)
            : Data.fromJson(json["data"][0]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.balance,
    this.shopId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int balance;
  int shopId;
  dynamic createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        balance: json["balance"],
        shopId: json["shop_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"]==null||json["updated_at"]==''?null: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "balance": balance,
        "shop_id": shopId,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
      };
}
