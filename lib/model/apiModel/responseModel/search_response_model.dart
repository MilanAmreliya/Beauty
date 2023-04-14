// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

SearchResponse searchResponseFromJson(String str) =>
    SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  SearchResponse({
    this.data,
  });

  List<Datum> data;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.username,
    this.usernameCanonical,
    this.email,
    this.emailCanonical,
    this.userStatusEnabled,
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
  dynamic lastLogin;
  dynamic locked;
  dynamic phoneNumber;
  dynamic expired;
  dynamic expiredAt;
  dynamic confirmationToken;
  dynamic passwordRequestedAt;
  dynamic credentailsExpireAt;
  dynamic name;
  String type;
  dynamic token;
  dynamic profilePic;
  String customerRole;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        username: json["username"],
        usernameCanonical: json["username_canonical"],
        email: json["email"],
        emailCanonical: json["email_canonical"],
        userStatusEnabled: json["user_status_enabled"],
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
