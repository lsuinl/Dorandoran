class ReadNoticeModel {
  final int notificationId;
  final int postId;
  final int? commentId;
  final int? replyId;
  final String notificationType;

  ReadNoticeModel({
    required this.notificationId,
    required this.postId,
    required this.commentId,
    required this.replyId,
    required this.notificationType,
  });
  factory ReadNoticeModel.fromJson(Map<String, dynamic> json) {
    return ReadNoticeModel(
      notificationId: json["notificationId"],
      postId: json["postId"],
      commentId: json["commentId"],
      replyId: json["replyId"],
      notificationType: json["notificationType"],
    );
  }
}