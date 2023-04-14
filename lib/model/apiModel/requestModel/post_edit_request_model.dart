class PostEditReq {
  String statusText;
  String statusHeadline;

  PostEditReq({this.statusText, this.statusHeadline});

  Map<String, dynamic> toJson() {
    return {
      'status_text': statusText,
      'status_headline': statusHeadline,
    };
  }
}
