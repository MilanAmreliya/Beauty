// To parse this JSON data, do
//
//     final artistPostResponse = artistPostResponseFromJson(jsonString);

import 'dart:convert';

ArtistPostResponse artistPostResponseFromJson(String str) => ArtistPostResponse.fromJson(json.decode(str));

String artistPostResponseToJson(ArtistPostResponse data) => json.encode(data.toJson());

class ArtistPostResponse {
  ArtistPostResponse({
    this.success,
    this.message,
    this.data,
    this.deviceToken,
    this.shop
  });

  bool success;
  String message;
  List<ArtistPostDatum> data;
  List<DeviceToken> deviceToken;
  List<Shop> shop;

  factory ArtistPostResponse.fromJson(Map<String, dynamic> json) => ArtistPostResponse(
    success: json["success"],
    message: json["message"],
    data: List<ArtistPostDatum>.from(json["data"].map((x) => ArtistPostDatum.fromJson(x))),
    deviceToken: List<DeviceToken>.from(json["deviceToken"].map((x) => DeviceToken.fromJson(x))),
    shop: List<Shop>.from(json["shop"].map((x) => Shop.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ArtistPostDatum {
  ArtistPostDatum({
    this.id,
    this.statusText,
    this.contentType,
    this.customerId,
    this.likeId,
    this.commentId,
    this.shareId,
    this.favouriteId,
    this.tagId,
    this.createdAt,
    this.updatedAt,
    this.feedImage,
  });

  int id;
  String statusText;
  String contentType;
  int customerId;
  dynamic likeId;
  dynamic commentId;
  dynamic shareId;
  dynamic favouriteId;
  dynamic tagId;
  DateTime createdAt;
  DateTime updatedAt;
  List<FeedImage> feedImage;

  factory ArtistPostDatum.fromJson(Map<String, dynamic> json) => ArtistPostDatum(
    id: json["id"],
    statusText: json["status_text"],
    contentType: json["content_type"],
    customerId: json["customer_id"],
    likeId: json["like_id"],
    commentId: json["comment_id"],
    shareId: json["share_id"],
    favouriteId: json["favourite_id"],
    tagId: json["tag_id"],
    createdAt: json["created_at"]==null?null:  DateTime.parse(json["created_at"]),
    updatedAt:  json["updated_at"]==null?null:DateTime.parse(json["updated_at"]),
    feedImage: List<FeedImage>.from(json["feed_image"].map((x) => FeedImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status_text": statusText,
    "content_type": contentType,
    "customer_id": customerId,
    "like_id": likeId,
    "comment_id": commentId,
    "share_id": shareId,
    "favourite_id": favouriteId,
    "tag_id": tagId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "feed_image": List<dynamic>.from(feedImage.map((x) => x.toJson())),
  };
}

class FeedImage {
  FeedImage({
    this.id,
    this.feedId,
    this.path,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int feedId;
  String path;
  DateTime createdAt;
  DateTime updatedAt;

  factory FeedImage.fromJson(Map<String, dynamic> json) => FeedImage(
    id: json["id"],
    feedId: json["feed_id"],
    path: json["path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "feed_id": feedId,
    "path": path,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class DeviceToken {
  DeviceToken({
    this.id,
    this.deviceToken,
    this.customerId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String deviceToken;
  int customerId;
  DateTime createdAt;
  DateTime updatedAt;

  factory DeviceToken.fromJson(Map<String, dynamic> json) => DeviceToken(
    id: json["id"],
    deviceToken: json["device_token"],
    customerId: json["customer_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "device_token": deviceToken,
    "customer_id": customerId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Shop {
  Shop({
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
  DateTime createdAt;
  DateTime updatedAt;
  String artist;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
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
    createdAt: json["created_at"] == null || json["created_at"] == ''
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null || json["updated_at"] == ''
        ? null
        : DateTime.parse(json["updated_at"]),
    artist: json["artist"]?.toString(),
  );
}