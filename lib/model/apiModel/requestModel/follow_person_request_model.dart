import 'package:beuty_app/sharedPreference/shared_preference.dart';

class FollowPersonRequestModel {
  String followingId;
  String followerId;
  String isFollowing;

  FollowPersonRequestModel(
      {this.followerId, this.followingId, this.isFollowing});

  Map<String, dynamic> toJson() {
    return {
      'follower_id': PreferenceManager.getArtistId().toString(),
      'following_id': followingId,
      'is_following': isFollowing,
    };
  }
}
