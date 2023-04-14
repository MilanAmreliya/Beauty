// To parse this JSON data, do
//
//     final updateProfileResponse = updateProfileResponseFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponse updateProfileResponseFromJson(String str) =>
    UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileResponseToJson(UpdateProfileResponse data) =>
    json.encode(data.toJson());

class UpdateProfileResponse {
  UpdateProfileResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponse(
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
    this.username,
    this.usernameCanonical,
    this.email,
    this.emailCanonical,
    this.userStatusEnabled,
    this.bio,
    this.lastLogin,
    this.locked,
    this.phoneNumber,
    this.expired,
    this.expiredAt,
    this.confirmationToken,
    this.passwordRequestedAt,
    this.credentailsExpireAt,
    this.name,
    this.type,
    this.token,
    this.profilePic,
    this.customerRole,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String username;
  dynamic usernameCanonical;
  String email;
  dynamic emailCanonical;
  int userStatusEnabled;
  String bio;
  dynamic lastLogin;
  dynamic locked;
  dynamic phoneNumber;
  dynamic expired;
  dynamic expiredAt;
  dynamic confirmationToken;
  dynamic passwordRequestedAt;
  dynamic credentailsExpireAt;
  String name;
  String type;
  dynamic token;
  String profilePic;
  String customerRole;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        usernameCanonical: json["username_canonical"],
        email: json["email"],
        emailCanonical: json["email_canonical"],
        userStatusEnabled: json["user_status_enabled"],
        bio: json["bio"],
        lastLogin: json["last_login"],
        locked: json["locked"],
        phoneNumber: json["phone_number"],
        expired: json["expired"],
        expiredAt: json["expired_at"],
        confirmationToken: json["confirmation_token"],
        passwordRequestedAt: json["password_requested_at"],
        credentailsExpireAt: json["credentails_expire_at"],
        name: json["name"],
        type: json["type"],
        token: json["token"],
        profilePic: json["profile_pic"],
        customerRole: json["customer_role"],
        createdAt:json["created_at"]==null?null: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"]==null?null: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "username_canonical": usernameCanonical,
        "email": email,
        "email_canonical": emailCanonical,
        "user_status_enabled": userStatusEnabled,
        "bio": bio,
        "last_login": lastLogin,
        "locked": locked,
        "phone_number": phoneNumber,
        "expired": expired,
        "expired_at": expiredAt,
        "confirmation_token": confirmationToken,
        "password_requested_at": passwordRequestedAt,
        "credentails_expire_at": credentailsExpireAt,
        "name": name,
        "type": type,
        "token": token,
        "profile_pic": profilePic,
        "customer_role": customerRole,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
