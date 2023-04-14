// To parse this JSON data, do
//
//     final shopSalesResponse = shopSalesResponseFromJson(jsonString);

import 'dart:convert';

ShopSalesResponse shopSalesResponseFromJson(String str) =>
    ShopSalesResponse.fromJson(json.decode(str));

String shopSalesResponseToJson(ShopSalesResponse data) =>
    json.encode(data.toJson());

class ShopSalesResponse {
  ShopSalesResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory ShopSalesResponse.fromJson(Map<String, dynamic> json) =>
      ShopSalesResponse(
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
    this.shopId,
    this.salePrice,
    this.salePriceAfterCut,
    this.appointmentId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int shopId;
  int salePrice;
  dynamic salePriceAfterCut;
  int appointmentId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        shopId: json["shop_id"],
        salePrice: json["sale_price"],
        salePriceAfterCut: json["sale_price_afterCut"],
        appointmentId: json["appointment_id"],
        createdAt: json["created_at"] == null || json["created_at"] == ''
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null || json["updated_at"] == ''
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "sale_price": salePrice,
        "sale_price_afterCut": salePriceAfterCut,
        "appointment_id": appointmentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
