import 'package:beuty_app/sharedPreference/shared_preference.dart';

class StoryCommentRequestModel {
  String comments;
  String storyId;
  String customerId;

  StoryCommentRequestModel({this.customerId, this.comments, this.storyId});

  Map<String, dynamic> toJson() {
    return {
      'comments': comments,
      'story_id': storyId,
      'customer_id': PreferenceManager.getArtistId().toString(),
    };
  }
}
