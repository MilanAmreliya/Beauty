import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;

class CreatePostReqModel {
  String contentType;
  String statusText;
  String customerId;
  List<Uint8List> feedUrl;

  CreatePostReqModel(
      {this.contentType, this.customerId, this.feedUrl, this.statusText});

  Future<Map<String, dynamic>> toJson() async {
    return {
      'status_headline': contentType,
      'status_text': statusText,
      'customer_id': customerId,
      'feed_url[]': feedUrl
          .map((e) => dio.MultipartFile.fromBytes(e,
              filename: '${DateTime.now().microsecondsSinceEpoch}.jpg'))
          .toList(),
    };
  }
}
