// To parse this JSON data, do
//
//     final followingFollowersResponse = followingFollowersResponseFromJson(jsonString);

import 'dart:convert';

FollowingFollowersResponse followingFollowersResponseFromJson(String str) => FollowingFollowersResponse.fromJson(json.decode(str));

String followingFollowersResponseToJson(FollowingFollowersResponse data) => json.encode(data.toJson());

class FollowingFollowersResponse {
  FollowingFollowersResponse({
    this.succes,
    this.followings,
    this.followers,
  });

  bool succes;
  List<Follow> followings;
  List<Follow> followers;

  factory FollowingFollowersResponse.fromJson(Map<String, dynamic> json) => FollowingFollowersResponse(
    succes: json["succes"],
    followings: List<Follow>.from(json["followings"].map((x) => Follow.fromJson(x))),
    followers: List<Follow>.from(json["followers"].map((x) => Follow.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "succes": succes,
    "followings": List<dynamic>.from(followings.map((x) => x.toJson())),
    "followers": List<dynamic>.from(followers.map((x) => x.toJson())),
  };
}

class Follow {
  Follow({
    this.id,
    this.name,
    this.username,
    this.image,
    this.role,
  });

  int id;
  String name;
  String username;
  String image;
  String role;

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    image: json["image"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "image": image,
    "role": role,
  };
}
