// To parse this JSON data, do
//
//     final modelAppointmentPendingResponse = modelAppointmentPendingResponseFromJson(jsonString);

import 'dart:convert';

ModelAppointmentPendingResponse modelAppointmentPendingResponseFromJson(
        String str) =>
    ModelAppointmentPendingResponse.fromJson(json.decode(str));

String modelAppointmentPendingResponseToJson(
        ModelAppointmentPendingResponse data) =>
    json.encode(data.toJson());

class ModelAppointmentPendingResponse {
  ModelAppointmentPendingResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory ModelAppointmentPendingResponse.fromJson(Map<String, dynamic> json) =>
      ModelAppointmentPendingResponse(
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
    this.modelId,
    this.artistId,
    this.serviceId,
    this.cuponId,
    this.paymentStatus,
    this.appointmentStatus,
    this.duration,
    this.ammount,
    this.discount,
    this.paymentToken,
    this.paymentType,
    this.address,
    this.lat,
    this.long,
    this.serviceType,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.artistName,
    this.serviceName,
    this.serviceStatus,
    this.price,
    this.image,
    this.rating,
    this.serviceCategory,
  });

  int id;
  int modelId;
  int artistId;
  int serviceId;
  dynamic cuponId;
  String paymentStatus;
  dynamic appointmentStatus;
  dynamic duration;
  var ammount;
  dynamic discount;
  dynamic paymentToken;
  String paymentType;
  dynamic address;
  dynamic lat;
  dynamic long;
  dynamic serviceType;
  dynamic description;
  dynamic date;
  DateTime startTime;
  dynamic endTime;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String artistName;
  String serviceName;
  dynamic serviceStatus;
  dynamic price;
  String image;
  dynamic rating;
  String serviceCategory;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        modelId: json["model_id"],
        artistId: json["artist_id"],
        serviceId: json["service_id"],
        cuponId: json["cupon_id"],
        paymentStatus: json["payment_status"],
        appointmentStatus: json["appointment_status"],
        duration: json["duration"],
        ammount: json["ammount"],
        discount: json["discount"],
        paymentToken: json["payment_token"],
        paymentType: json["payment_type"],
        address: json["address"],
        lat: json["lat"],
        long: json["long"],
        serviceType: json["service_type"],
        description: json["description"],
        date: json["date"],
        startTime: json["start_time"]==null?null:DateTime.parse(json["start_time"]),
        endTime: json["end_time"],
        status: json["status"],
        createdAt:json["created_at"]==null?null: DateTime.parse(json["created_at"]),
        updatedAt:  json["updated_at"]==null?null:DateTime.parse(json["updated_at"]),
        artistName: json["artist name"],
        serviceName: json["service_name"],
        serviceStatus: json["serviceStatus"],
        price: json["price"],
        image: json["image"],
        rating: json["rating"],
        serviceCategory: json["service_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "model_id": modelId,
        "artist_id": artistId,
        "service_id": serviceId,
        "cupon_id": cuponId,
        "payment_status": paymentStatus,
        "appointment_status": appointmentStatus,
        "duration": duration,
        "ammount": ammount,
        "discount": discount,
        "payment_token": paymentToken,
        "payment_type": paymentType,
        "address": address,
        "lat": lat,
        "long": long,
        "service_type": serviceType,
        "description": description,
        "date": date,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "artist name": artistName,
        "service_name": serviceName,
        "serviceStatus": serviceStatus,
        "price": price,
        "image": image,
        "rating": rating,
        "service_category": serviceCategory,
      };
}
