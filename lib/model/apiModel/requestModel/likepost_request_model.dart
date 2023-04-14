import 'package:beuty_app/sharedPreference/shared_preference.dart';

class IsLikedPostReq {
  String likerId;
  String postId;
  String isLiked;

  IsLikedPostReq({this.likerId, this.isLiked, this.postId});

 Map<String, String> toJson()  {
    return {
      'liker_id': PreferenceManager.getArtistId().toString(),
      // 'liker_id': likerId,
      'post_id': postId,
      'is_liked': isLiked,
    };
  }
}
