

class CreateCommentPostReq {
  String comment;
  String postId;
  String commenterId;

  CreateCommentPostReq({this.comment, this.commenterId, this.postId});

  Future<Map<String, String>> toJson() async {
    return {
      'comment': comment,
      'post_id': postId,
      'commenter_id': commenterId,
    };
  }
}
