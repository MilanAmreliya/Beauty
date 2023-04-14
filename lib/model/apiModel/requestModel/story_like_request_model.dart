import 'package:beuty_app/sharedPreference/shared_preference.dart';

class StoryLikeRequestModel {
  String storyId;
  String isLiked;
  String likedId;

  StoryLikeRequestModel({this.storyId, this.isLiked, this.likedId});

  Map<String, dynamic> toJson() {
    return {
      'story_id': storyId,
      'is_liked': isLiked,
      'liker_id': PreferenceManager.getArtistId().toString()
    };
  }
}
