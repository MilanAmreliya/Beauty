// To parse this JSON data, do
//
//     final homeArtistResponse = homeArtistResponseFromJson(jsonString);

import 'dart:convert';

HomeArtistResponse homeArtistResponseFromJson(String str) =>
    HomeArtistResponse.fromJson(json.decode(str));


class HomeArtistResponse {
  HomeArtistResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory HomeArtistResponse.fromJson(Map<String, dynamic> json) =>
      HomeArtistResponse(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

}

class Datum {
  Datum({
    this.id,
    this.name,
    this.img,
    this.address,
    this.lati,
    this.longi,
    this.shopRating,
    this.map,
    this.place,
    this.aboutShop,
    this.shopNo,
    this.shopServicesId,
    this.artistId,
    this.createdAt,
    this.updatedAt,
    this.artist,
    this.services,
    this.rating,
  });

  int id;
  String name;
  String img;
  String address;
  String lati;
  String longi;
  int shopRating;
  dynamic map;
  String place;
  String aboutShop;
  dynamic shopNo;
  dynamic shopServicesId;
  int artistId;
  String createdAt;
  String updatedAt;
  List<Artist> artist;
  List<Service> services;
  int rating;

  factory Datum.fromJson(Map<String, dynamic> json) =>
      Datum(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        address: json["address"],
        lati: json["lati"],
        longi: json["longi"],
        shopRating: json["shop_rating"],
        map: json["map"],
        place: json["place"],
        aboutShop: json["about_shop"],
        shopNo: json["shop_no"],
        shopServicesId: json["shop_services_id"],
        artistId: json["artist_id"],
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
        artist: List<Artist>.from(
            json["artist"].map((x) => Artist.fromJson(x))),
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
        rating: json["rating"],
      );

}

class Artist {
  Artist({
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
  String createdAt;
  String updatedAt;

  factory Artist.fromJson(Map<String, dynamic> json) =>
      Artist(
        id: json["id"],
        username: json["username"],
        usernameCanonical: json["username_canonical"],
        email: json["email"],
        emailCanonical: json["email_canonical"],
        userStatusEnabled: json["user_status_enabled"],
        bio: json["bio"] == null ? null : json["bio"],
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
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
      );

}

class Service {
  Service({
    this.id,
    this.serviceName,
    this.image,
    this.serviceCategoryId,
    this.price,
    this.artistId,
    this.tags,
    this.shopId,
    this.startTime,
    this.endTime,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.serviceRating,
  });

  int id;
  String serviceName;
  String image;
  int serviceCategoryId;
  String price;
  int artistId;
  dynamic tags;
  int shopId;
  String startTime;
  String endTime;
  String description;
  dynamic status;
  String createdAt;
  String updatedAt;
  dynamic serviceRating;

  factory Service.fromJson(Map<String, dynamic> json) =>
      Service(
        id: json["id"],
        serviceName: json["service_name"],
        image: json["image"],
        serviceCategoryId: json["serviceCategory_id"],
        price: json["price"],
        artistId: json["artist_id"],
        tags: json["tags"],
        shopId: json["shop_id"],
        startTime: json["start_time"],
        endTime: json["end_time"] ?? '',
        description: json["description"],
        status: json["status"],
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
        serviceRating: json["service_rating"],
      );

}
