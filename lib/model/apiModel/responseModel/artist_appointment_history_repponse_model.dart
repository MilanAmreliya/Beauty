// To parse this JSON data, do
//
//     final appointmentHistoryResponse = appointmentHistoryResponseFromJson(jsonString);

import 'dart:convert';

ArtistAppointmentHistoryResponse appointmentHistoryResponseFromJson(
        String str) =>
    ArtistAppointmentHistoryResponse.fromJson(json.decode(str));

String appointmentHistoryResponseToJson(
        ArtistAppointmentHistoryResponse data) =>
    json.encode(data.toJson());

class ArtistAppointmentHistoryResponse {
  ArtistAppointmentHistoryResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<HistoryDatum> data;

  factory ArtistAppointmentHistoryResponse.fromJson(
          Map<String, dynamic> json) =>
      ArtistAppointmentHistoryResponse(
        success: json["success"],
        message: json["message"],
        data: List<HistoryDatum>.from(
            json["data"].map((x) => HistoryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class HistoryDatum {
  HistoryDatum({
    this.id,
    this.appointmentId,
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
    this.modelName,
    this.serviceName,
    this.serviceStatus,
    this.price,
    this.serviceCategory,
  });

  int id;
  int appointmentId;
  int modelId;
  int artistId;
  int serviceId;
  dynamic cuponId;
  String paymentStatus;
  String appointmentStatus;
  String duration;
  dynamic ammount;
  dynamic discount;
  dynamic paymentToken;
  dynamic paymentType;
  String address;
  dynamic lat;
  dynamic long;
  String serviceType;
  String description;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  String status;
  String modelName;
  String serviceName;
  dynamic serviceStatus;
  dynamic price;
  String serviceCategory;

  factory HistoryDatum.fromJson(Map<String, dynamic> json) => HistoryDatum(
        id: json["id"],
        appointmentId: json["appointment_id_"],
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
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        status: json["status"],
        modelName: json["model_name"],
        serviceName: json["service_name"],
        serviceStatus: json["serviceStatus"],
        price: json["price"],
        serviceCategory: json["service_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "appointment_id": appointmentId,
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
        "date": date.toIso8601String(),
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "status": status,
        "model_name": modelName,
        "service_name": serviceName,
        "serviceStatus": serviceStatus,
        "price": price,
        "service_category": serviceCategory,
      };
}
