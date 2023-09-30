class replycard {
  final int replyId;
  final String replyNickname;
  final String reply;
  final String replyAnonymityNickname;
  final bool replyCheckDelete;
  final bool isWrittenByMember;
  final String replyTime;
  final bool isLocked;

  replycard({
    required this.replyId,
    required this.replyNickname,
    required this.reply,
    required this.replyAnonymityNickname,
    required this.replyCheckDelete,
    required this.replyTime,
    required this.isLocked,
    required this.isWrittenByMember
  });
  factory replycard.fromJson(Map<String, dynamic> json) {
    return replycard(
      replyId: json["replyId"],
      replyNickname: json["replyNickname"],
      reply: json["reply"],
      isLocked: json["isLocked"],
      replyAnonymityNickname: json["replyAnonymityNickname"],
      replyCheckDelete: json["replyCheckDelete"],
      replyTime: json["replyTime"],
      isWrittenByMember: json["isWrittenByMember"]
    );
  }
}
