// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  LoginResponse(
      {this.success, this.message, this.token, this.user, this.promotion});

  bool success;
  String message;
  String token;
  User user;
  List<Promotion> promotion;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        message: json["message"],
        token: json["token"],
        user: User.fromJson(json["user"]),
        promotion: User.fromJson(json["user"]).customerRole == "Model"
            ? []
            : (!json.containsKey('promotion'))?[]:List<Promotion>.from(
                json["promotion"].map((x) => Promotion.fromJson(x))),
      );
}

class User {
  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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

class Promotion {
  Promotion({
    this.id,
    this.shopId,
    this.startDate,
    this.endDate,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int shopId;
  DateTime startDate;
  DateTime endDate;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;

  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
        id: json["id"],
        shopId: json["shop_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
