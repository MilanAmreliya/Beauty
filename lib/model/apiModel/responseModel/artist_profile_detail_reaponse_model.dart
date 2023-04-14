// To parse this JSON data, do
//
//     final artistProfileDetailResponse = artistProfileDetailResponseFromJson(jsonString);

import 'dart:convert';

ArtistProfileDetailResponse artistProfileDetailResponseFromJson(String str) =>
    ArtistProfileDetailResponse.fromJson(json.decode(str));

String artistProfileDetailResponseToJson(ArtistProfileDetailResponse data) =>
    json.encode(data.toJson());

class ArtistProfileDetailResponse {
  ArtistProfileDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory ArtistProfileDetailResponse.fromJson(Map<String, dynamic> json) =>
      ArtistProfileDetailResponse(
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
  Data(
      {this.name,
      this.username,
      this.followerCount,
      this.followingCount,
      this.postCount,
      this.review,
      this.image,
      this.bio,
      this.role});

  String name;
  String username;
  int followerCount;
  int followingCount;
  int postCount;
  int review;
  String image;
  String role;
  String bio;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        username: json["username"],
        followerCount: json["followerCount"],
        followingCount: json["followingCount"],
        postCount: json["postCount"],
        review: json["review"],
        image: json["image"],
        role: json["role"],
        bio: json['bio'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "followerCount": followerCount,
        "followingCount": followingCount,
        "postCount": postCount,
        "review": review,
        "image": image,
      };
}
