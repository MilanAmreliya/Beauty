import 'package:beuty_app/sharedPreference/shared_preference.dart';

class IsFavoriteReq {
  String postId;
  String customerId;
  String isFav;

  IsFavoriteReq({this.isFav, this.postId, this.customerId});

  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      // 'customer_id': '54',
      'customer_id': PreferenceManager.getArtistId().toString(),
      'isFav': isFav
    };
  }
}
