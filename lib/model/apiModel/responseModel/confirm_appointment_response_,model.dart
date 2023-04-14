// To parse this JSON data, do
//
//     final confirmAppointmentResponse = confirmAppointmentResponseFromJson(jsonString);

import 'dart:convert';

ConfirmAppointmentResponse confirmAppointmentResponseFromJson(String str) => ConfirmAppointmentResponse.fromJson(json.decode(str));

String confirmAppointmentResponseToJson(ConfirmAppointmentResponse data) => json.encode(data.toJson());

class ConfirmAppointmentResponse {
  ConfirmAppointmentResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory ConfirmAppointmentResponse.fromJson(Map<String, dynamic> json) => ConfirmAppointmentResponse(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
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
  });

  int id;
  int modelId;
  int artistId;
  int serviceId;
  dynamic cuponId;
  String paymentStatus;
  dynamic appointmentStatus;
  dynamic duration;
  int ammount;
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    startTime:json["start_time"]==null?null: DateTime.parse(json["start_time"]),
    endTime: json["end_time"],
    status: json["status"],
    createdAt:json["created_at"]==null?null: DateTime.parse(json["created_at"]),
    updatedAt:  json["updated_at"]==null?null:DateTime.parse(json["updated_at"]),
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
  };
}
