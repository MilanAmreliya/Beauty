// To parse this JSON data, do
//
//     final serviceProviedByshopResponse = serviceProviedByshopResponseFromJson(jsonString);

import 'dart:convert';

ServiceProviedByshopResponse serviceProviedByshopResponseFromJson(String str) => ServiceProviedByshopResponse.fromJson(json.decode(str));

String serviceProviedByshopResponseToJson(ServiceProviedByshopResponse data) => json.encode(data.toJson());

class ServiceProviedByshopResponse {
  ServiceProviedByshopResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory ServiceProviedByshopResponse.fromJson(Map<String, dynamic> json) => ServiceProviedByshopResponse(
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
    this.serviceName,
    this.image,
    this.createdAt,
    this.price,
    this.serviceCategoryName,
    this.serviceStartTime,
    this.ammount,
    this.total,
  });

  String serviceName;
  String image;
  DateTime createdAt;
  dynamic price;
  String serviceCategoryName;
  String serviceStartTime;
  dynamic ammount;
  dynamic total;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    serviceName: json["service_name"],
    image: json["image"],
    createdAt: json["created_at"]==null?null:DateTime.parse(json["created_at"]),
    price: json["price"],
    serviceCategoryName: json["service_category_name"],
    serviceStartTime: json["service start time"],
    ammount: json["ammount"],
    total: json["Total"],
  );

  Map<String, dynamic> toJson() => {
    "service_name": serviceName,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "price": price,
    "service_category_name": serviceCategoryName,
    "service start time": serviceStartTime,
    "ammount": ammount,
    "Total": total,
  };
}
