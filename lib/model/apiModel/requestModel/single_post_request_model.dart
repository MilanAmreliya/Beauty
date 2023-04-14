// import 'package:beuty_app/model/apiModel/responseModel/home_screen_feed_response_model.dart';

class SinglePostRequestModel {
  String artistId;
  String postId;
  List<String> postImg;
  String statusText;
  List<String> deviceTokens;
  bool isLike;
  String address;

  SinglePostRequestModel._internal();

  static final SinglePostRequestModel _singlePostRequestModel =
      SinglePostRequestModel._internal();

  factory SinglePostRequestModel() {
    return _singlePostRequestModel;
  }
}

class EditPostRequestModel {
  String postId;
  List<String> postImg;
  String statusText;
  EditPostRequestModel._internal();
  static final EditPostRequestModel _editPostRequestModel =
      EditPostRequestModel._internal();
  factory EditPostRequestModel() {
    return _editPostRequestModel;
  }
}
