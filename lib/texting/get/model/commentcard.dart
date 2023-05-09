class commentcard {
  final int commentId;
  final String comment;
  final String commentLike;
  final int? commentLikeResult;
  final int commentNickname;
  final bool commentCheckDelete;
  final String commentTime;
  final int? replies;
  final String commentAnonymityNickname;

  commentcard({
    required this.commentId,
    required this.comment,
    required this.commentLike,
    required this.commentLikeResult,
    required this.commentNickname,
    required this.commentCheckDelete,
    required this.commentTime,
    required this.replies,
    required this.commentAnonymityNickname,
  });
  factory commentcard.fromJson(Map<String, dynamic> json) {
    return postcard(
        commentId: json["postId"],
        comment: json["contents"],
        commentLike: json["postTime"],
        commentLikeResult: json["location"],
        commentNickname: json["likeCnt"],
        commentCheckDelete: json["likeResult"],
        commentTime: json["backgroundPicUri"],
        replies: json["font"],
        commentAnonymityNickname: json["fontColor"],
    );
  }
}
