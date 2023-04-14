// To parse this JSON data, do
//
//     final createAppointmentResponse = createAppointmentResponseFromJson(jsonString);

import 'dart:convert';

CreateAppointmentResponse createAppointmentResponseFromJson(String str) =>
    CreateAppointmentResponse.fromJson(json.decode(str));

String createAppointmentResponseToJson(CreateAppointmentResponse data) =>
    json.encode(data.toJson());

class CreateAppointmentResponse {
  CreateAppointmentResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory CreateAppointmentResponse.fromJson(Map<String, dynamic> json) =>
      CreateAppointmentResponse(
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
    this.artistId,
    this.modelId,
    this.serviceId,
    this.status,
    this.ammount,
    this.paymentType,
    this.paymentStatus,
    this.startTime,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String artistId;
  String modelId;
  String serviceId;
  String status;
  String ammount;
  String paymentType;
  String paymentStatus;
  DateTime startTime;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        artistId: json["artist_id"],
        modelId: json["model_id"],
        serviceId: json["service_id"],
        status: json["status"],
        ammount: json["ammount"],
        paymentType: json["payment_type"],
        paymentStatus: json["payment_status"],
        startTime:json["start_time"]==null?null: DateTime.parse(json["start_time"]),
        updatedAt:  json["updated_at"]==null?null:DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"]==null?null:DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "artist_id": artistId,
        "model_id": modelId,
        "service_id": serviceId,
        "status": status,
        "ammount": ammount,
        "payment_type": paymentType,
        "payment_status": paymentStatus,
        "start_time": startTime.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
