// To parse this JSON data, do
//
//     final modelLikedFeedResponse = modelLikedFeedResponseFromJson(jsonString);

import 'dart:convert';

ModelLikedFeedResponse modelLikedFeedResponseFromJson(String str) => ModelLikedFeedResponse.fromJson(json.decode(str));

String modelLikedFeedResponseToJson(ModelLikedFeedResponse data) => json.encode(data.toJson());

class ModelLikedFeedResponse {
  ModelLikedFeedResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory ModelLikedFeedResponse.fromJson(Map<String, dynamic> json) => ModelLikedFeedResponse(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.statusText,
    this.statusHeadline,
    this.customerId,
    this.likeId,
    this.commentId,
    this.shareId,
    this.tagId,
    this.createdAt,
    this.updatedAt,
    this.feedImage,
    this.user,
  });

  int id;
  String statusText;
  dynamic statusHeadline;
  int customerId;
  dynamic likeId;
  dynamic commentId;
  dynamic shareId;
  dynamic tagId;
  DateTime createdAt;
  DateTime updatedAt;
  List<FeedImage> feedImage;
  User user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    statusText: json["status_text"],
    statusHeadline: json["status_headline"],
    customerId: json["customer_id"],
    likeId: json["like_id"],
    commentId: json["comment_id"],
    shareId: json["share_id"],
    tagId: json["tag_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    feedImage: List<FeedImage>.from(json["feed_image"].map((x) => FeedImage.fromJson(x))),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status_text": statusText,
    "status_headline": statusHeadline,
    "customer_id": customerId,
    "like_id": likeId,
    "comment_id": commentId,
    "share_id": shareId,
    "tag_id": tagId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "feed_image": List<dynamic>.from(feedImage.map((x) => x.toJson())),
    "user": user.toJson(),
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
    this.shop,
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
  Shop shop;

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
    shop: Shop.fromJson(json["shop"]),
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
    "shop": shop.toJson(),
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
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "img": img,
    "address": address,
    "lati": lati,
    "longi": longi,
    "shop_rating": shopRating,
    "map": map,
    "place": place,
    "about_shop": aboutShop,
    "shop_no": shopNo,
    "shop_services_id": shopServicesId,
    "artist_id": artistId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
