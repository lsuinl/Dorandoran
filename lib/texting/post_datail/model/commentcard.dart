class commentcard {
  final int commentId;
  final String comment;
  final int commentLike;
  final bool commentLikeResult;
  final String commentNickname;
  final bool commentCheckDelete;
  final String commentTime;
  final int countReply;
  final List<dynamic> replies;
  final String? commentAnonymityNickname;

  commentcard({
    required this.commentId,
    required this.comment,
    required this.commentLike,
    required this.commentLikeResult,
    required this.commentNickname,
    required this.commentCheckDelete,
    required this.commentTime,
    required this.countReply,
    required this.replies,
    required this.commentAnonymityNickname,
  });
  factory commentcard.fromJson(Map<String, dynamic> json) {
    return commentcard(
        commentId: json["commentId"],
        comment: json["comment"],
        commentLike: json["commentLike"],
        commentLikeResult: json["commentLikeResult"],
        commentNickname: json["commentNickname"],
        commentCheckDelete: json["commentCheckDelete"],
        commentTime: json["commentTime"],
        countReply: json["countReply"],
        replies: json["replies"],
        commentAnonymityNickname: json["commentAnonymityNickname"],
    );
  }
}
