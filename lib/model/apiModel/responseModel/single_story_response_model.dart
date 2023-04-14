// To parse this JSON data, do
//
//     final singleStoryResponse = singleStoryResponseFromJson(jsonString);

import 'dart:convert';

SingleStoryResponse singleStoryResponseFromJson(String str) => SingleStoryResponse.fromJson(json.decode(str));

String singleStoryResponseToJson(SingleStoryResponse data) => json.encode(data.toJson());

class SingleStoryResponse {
  SingleStoryResponse({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory SingleStoryResponse.fromJson(Map<String, dynamic> json) => SingleStoryResponse(
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
    this.id,
    this.artistId,
    this.storySize,
    this.createdAt,
    this.updatedAt,
    this.containTag,
    this.commentId,
    this.storyImages,
    this.userName,
    this.userRole,
    this.userPic,
    this.isLiked,
  });

  int id;
  int artistId;
  String storySize;
  DateTime createdAt;
  DateTime updatedAt;
  String containTag;
  dynamic commentId;
  List<StoryImage> storyImages;
  dynamic userName;
  String userRole;
  dynamic userPic;
  bool isLiked;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    artistId: json["artist_id"],
    storySize: json["story_size"],
    createdAt:json["created_at"]==null?null: DateTime.parse(json["created_at"]),
    updatedAt:  json["updated_at"]==null?null:DateTime.parse(json["updated_at"]),
    containTag: json["contain_tag"],
    commentId: json["comment_id"],
    storyImages: List<StoryImage>.from(json["story_images"].map((x) => StoryImage.fromJson(x))),
    userName: json["user_name"],
    userRole: json["user_role"],
    userPic: json["user_pic"],
    isLiked: json["isLiked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "artist_id": artistId,
    "story_size": storySize,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "contain_tag": containTag,
    "comment_id": commentId,
    "story_images": List<dynamic>.from(storyImages.map((x) => x.toJson())),
    "user_name": userName,
    "user_role": userRole,
    "user_pic": userPic,
    "isLiked": isLiked,
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
    createdAt: json["created_at"]==null?null:DateTime.parse(json["created_at"]),
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
