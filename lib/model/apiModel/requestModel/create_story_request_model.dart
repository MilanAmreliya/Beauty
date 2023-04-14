import 'dart:typed_data';

import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:dio/dio.dart' as dio;

class CreateStoryReqModel {
  String artistId;
  String storySize;
  String containTag;
  List<Uint8List> storyUrl;

  CreateStoryReqModel(
      {this.artistId, this.containTag, this.storySize, this.storyUrl});

  Future<Map<String, dynamic>> toJson() async {
    return {
      'artist_id': PreferenceManager.getArtistId().toString(),
      'story_size': storySize ?? "1",
      'contain_tag': containTag ?? 'demo',
      'story_url[]': storyUrl
          .map((e) => dio.MultipartFile.fromBytes(e,
              filename: '${DateTime.now().microsecondsSinceEpoch}.jpg'))
          .toList(),
      /*'story_url[]': dio.MultipartFile.fromBytes(storyUrl,
          filename: '${DateTime.now().microsecondsSinceEpoch}.jpg'),*/
    };
  }
}
