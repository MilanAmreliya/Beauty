// To parse this JSON data, do
//
//     final appointmentBookedResponse = appointmentBookedResponseFromJson(jsonString);

import 'dart:convert';

ArtistAppointmentBookedResponse appointmentBookedResponseFromJson(String str) =>
    ArtistAppointmentBookedResponse.fromJson(json.decode(str));


class ArtistAppointmentBookedResponse {
  ArtistAppointmentBookedResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<BookedDatum> data;

  factory ArtistAppointmentBookedResponse.fromJson(Map<String, dynamic> json) =>
      ArtistAppointmentBookedResponse(
        success: json["success"],
        message: json["message"],
        data: List<BookedDatum>.from(
            json["data"].map((x) => BookedDatum.fromJson(x))),
      );

}

class BookedDatum {
  BookedDatum({
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
    this.modelName,
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
  String appointmentStatus;
  String duration;
  int ammount;
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
  dynamic createdAt;
  dynamic updatedAt;
  String modelName;
  dynamic serviceName;
  dynamic serviceStatus;
  dynamic price;
  dynamic image;
  dynamic rating;
  dynamic serviceCategory;

  factory BookedDatum.fromJson(Map<String, dynamic> json) => BookedDatum(
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
        date: json["date"]!=null?DateTime.parse(json["date"]):null,
        startTime: json["start_time"]!=null?DateTime.parse(json["start_time"]):null,
        endTime:json["end_time_"]!=null? DateTime.parse(json["end_time_"]):null,
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        modelName: json["model_name"],
        serviceName: json["service_name"],
        serviceStatus: json["serviceStatus"],
        price: json["price"],
        image: json["image"],
        rating: json["rating"],
        serviceCategory: json["service_category"],
      );

}
