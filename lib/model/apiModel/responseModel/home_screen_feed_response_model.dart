// To parse this JSON data, do
//
//     final homeScreenFeedResponse = homeScreenFeedResponseFromJson(jsonString);

import 'dart:convert';

HomeScreenFeedResponse homeScreenFeedResponseFromJson(String str) =>
    HomeScreenFeedResponse.fromJson(json.decode(str));

class HomeScreenFeedResponse {
  HomeScreenFeedResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory HomeScreenFeedResponse.fromJson(Map<String, dynamic> json) =>
      HomeScreenFeedResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.posts,
    this.promotedShop,
  });

  List<Post> posts;
  List<Shop> promotedShop;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        promotedShop:
            List<Shop>.from(json["promotedShop"].map((x) => Shop.fromJson(x))),
      );
}

class Post {
  Post({
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
    this.user,
    this.feedImage,
    this.comments,
  });

  int id;
  String statusText;
  String statusHeadline;
  int customerId;
  dynamic likeId;
  dynamic commentId;
  dynamic shareId;
  dynamic tagId;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  List<FeedImage> feedImage;
  List<UserComment> comments;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        statusText: json["status_text"],
        statusHeadline:
            json["status_headline"] == null ? null : json["status_headline"],
        customerId: json["customer_id"],
        likeId: json["like_id"],
        commentId: json["comment_id"],
        shareId: json["share_id"],
        tagId: json["tag_id"],
        createdAt: json["created_at"] == null || json["created_at"] == ''
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null || json["updated_at"] == ''
            ? null
            : DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
        feedImage: List<FeedImage>.from(
            json["feed_image"].map((x) => FeedImage.fromJson(x))),
        comments: List<UserComment>.from(
            json["comments"].map((x) => UserComment.fromJson(x))),
      );
}

class UserComment {
  UserComment({
    this.id,
    this.customerId,
    this.comment,
    this.containsUrl,
    this.createdAt,
    this.updatedAt,
    this.feedId,
    this.user,
  });

  int id;
  int customerId;
  String comment;
  dynamic containsUrl;
  DateTime createdAt;
  DateTime updatedAt;
  int feedId;
  User user;

  factory UserComment.fromJson(Map<String, dynamic> json) => UserComment(
        id: json["id"],
        customerId: json["customer_id"],
        comment: json["comment"],
        containsUrl: json["contains_url"],
        createdAt: json["created_at"] == null || json["created_at"] == ''
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null || json["updated_at"] == ''
            ? null
            : DateTime.parse(json["updated_at"]),
        feedId: json["feed_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );
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
  User artist;

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
        artist: json["artist"] == null ? null : User.fromJson(json["artist"]),
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
    this.deviceTokens,
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
  List<DeviceToken> deviceTokens;
  Shop shop;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        createdAt: json["created_at"] == null || json["created_at"] == ''
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null || json["updated_at"] == ''
            ? null
            : DateTime.parse(json["updated_at"]),
        deviceTokens: json["device_tokens"] == null
            ? null
            : List<DeviceToken>.from(
                json["device_tokens"].map((x) => DeviceToken.fromJson(x))),
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
      );
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
        createdAt: json["created_at"] == null || json["created_at"] == ''
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null || json["updated_at"] == ''
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "device_token": deviceToken,
        "customer_id": customerId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
        createdAt: json["created_at"] == null || json["created_at"] == ''
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null || json["updated_at"] == ''
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "feed_id": feedId,
        "path": path,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
