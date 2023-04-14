// To parse this JSON data, do
//
//     final getArtistAllStoryResponse = getArtistAllStoryResponseFromJson(jsonString);

import 'dart:convert';

GetArtistAllStoryResponse getArtistAllStoryResponseFromJson(String str) => GetArtistAllStoryResponse.fromJson(json.decode(str));

String getArtistAllStoryResponseToJson(GetArtistAllStoryResponse data) => json.encode(data.toJson());

class GetArtistAllStoryResponse {
  GetArtistAllStoryResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory GetArtistAllStoryResponse.fromJson(Map<String, dynamic> json) => GetArtistAllStoryResponse(
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
    this.artistId,
    this.storySize,
    this.createdAt,
    this.updatedAt,
    this.containTag,
    this.commentId,
    this.user,
    this.storyImage,
  });

  int id;
  int artistId;
  String storySize;
  DateTime createdAt;
  DateTime updatedAt;
  String containTag;
  dynamic commentId;
  User user;
  List<StoryImage> storyImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    artistId: json["artist_id"],
    storySize: json["story_size"],
    createdAt: json["created_at"]==null?null:DateTime.parse(json["created_at"]),
    updatedAt:  json["updated_at"]==null?null:DateTime.parse(json["updated_at"]),
    containTag: json["contain_tag"],
    commentId: json["comment_id"],
    user: User.fromJson(json["user"]),
    storyImage: List<StoryImage>.from(json["story_image"].map((x) => StoryImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "artist_id": artistId,
    "story_size": storySize,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "contain_tag": containTag,
    "comment_id": commentId,
    "user": user.toJson(),
    "story_image": List<dynamic>.from(storyImage.map((x) => x.toJson())),
  };
}

class StoryImage {
  StoryImage({
    this.id,
    this.storyId,
    this.path,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int storyId;
  String path;
  DateTime createdAt;
  DateTime updatedAt;

  factory StoryImage.fromJson(Map<String, dynamic> json) => StoryImage(
    id: json["id"],
    storyId: json["story_id"],
    path: json["path"],
    createdAt:json["created_at"]==null?null: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"]==null?null: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "story_id": storyId,
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
    createdAt: json["created_at"]==null?null:DateTime.parse(json["created_at"]),
    updatedAt:  json["updated_at"]==null?null:DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "username_canonical": usernameCanonical,
    "email": email,
    "email_canonical": emailCanonical,
    "user_status_enabled": userStatusEnabled,
    "bio": bio == null ? null : bio,
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
