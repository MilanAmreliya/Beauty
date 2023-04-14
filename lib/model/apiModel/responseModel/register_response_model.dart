// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.success,
    this.message,
    this.customers,
    this.accessToken,
  });

  bool success;
  String message;
  Customers customers;
  String accessToken;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        success: json["success"],
        message: json["message"],
        customers: json["message"] != "register successfully"
            ? Customers()
            : Customers.fromJson(json["customers"]),
        accessToken: json["message"] != "register successfully"
            ? ""
            : json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "customers": customers.toJson(),
        "access_token": accessToken,
      };
}

class Customers {
  Customers({
    this.name,
    this.email,
    this.customerRole,
    this.username,
    this.type,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String name;
  String email;
  String customerRole;
  String username;
  String type;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
        name: json["name"],
        email: json["email"],
        customerRole: json["customer_role"],
        username: json["username"],
        type: json["type"],
        updatedAt: json["updated_at"]==null?null: DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"]==null?null:DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "customer_role": customerRole,
        "username": username,
        "type": type,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
