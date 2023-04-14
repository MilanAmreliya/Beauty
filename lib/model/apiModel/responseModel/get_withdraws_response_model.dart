// To parse this JSON data, do
//
//     final getWithdrawResponse = getWithdrawResponseFromJson(jsonString);

import 'dart:convert';

GetWithdrawResponse getWithdrawResponseFromJson(String str) =>
    GetWithdrawResponse.fromJson(json.decode(str));

String getWithdrawResponseToJson(GetWithdrawResponse data) =>
    json.encode(data.toJson());

class GetWithdrawResponse {
  GetWithdrawResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory GetWithdrawResponse.fromJson(Map<String, dynamic> json) =>
      GetWithdrawResponse(
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
    this.withdraws,
  });

  List<Withdraw> withdraws;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        withdraws: List<Withdraw>.from(
            json["withdraws"].map((x) => Withdraw.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "withdraws": List<dynamic>.from(withdraws.map((x) => x.toJson())),
      };
}

class Withdraw {
  Withdraw({
    this.id,
    this.ammount,
    this.artistAccountName,
    this.artistBsbNumber,
    this.artistAccountNumber,
    this.shopId,
    this.status,
    this.image,
    this.transactionId,
    this.comment,
    this.adminContactMail,
    this.adminPercentage,
    this.amountAfterAdminCut,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.userRole,
    this.artistImage,
  });

  int id;
  dynamic ammount;
  String artistAccountName;
  String artistBsbNumber;
  String artistAccountNumber;
  int shopId;
  String status;
  dynamic image;
  dynamic transactionId;
  dynamic comment;
  String adminContactMail;
  dynamic adminPercentage;
  dynamic amountAfterAdminCut;
  DateTime createdAt;
  DateTime updatedAt;
  String user;
  String userRole;
  String artistImage;

  factory Withdraw.fromJson(Map<String, dynamic> json) => Withdraw(
        id: json["id"],
        ammount: json["ammount"],
        artistAccountName: json["artist_account_name"],
        artistBsbNumber: json["artist_bsb_number"],
        artistAccountNumber: json["artist_account_number"],
        shopId: json["shop_id"],
        status: json["status"],
        image: json["image"],
        transactionId: json["transaction_id"],
        comment: json["comment"],
        adminContactMail: json["admin_contact_mail"] == null
            ? null
            : json["admin_contact_mail"],
        adminPercentage: json["admin_percentage"],
        amountAfterAdminCut: json["amount_after_adminCut"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"],
        userRole: json["user_role"],
        artistImage: json["artistImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ammount": ammount,
        "artist_account_name": artistAccountName,
        "artist_bsb_number": artistBsbNumber,
        "artist_account_number": artistAccountNumber,
        "shop_id": shopId,
        "status": status,
        "image": image,
        "transaction_id": transactionId,
        "comment": comment,
        "admin_contact_mail":
            adminContactMail == null ? null : adminContactMail,
        "admin_percentage": adminPercentage,
        "amount_after_adminCut": amountAfterAdminCut,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user,
        "user_role": userRole,
        "artistImage": artistImage,
      };
}
