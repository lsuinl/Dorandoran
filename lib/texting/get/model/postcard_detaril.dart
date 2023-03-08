class CommentDetailDto {
  late String comment;
  late int commentLike;
  late bool commentLikeResult;
//List<Reply> replies;
}

class postcardDetail {
  final String content;
  final String postTime;
  final String? location;
  final int postLikeCnt;
  final bool? postLikeResult;
  final int commentCnt;
  final String backgroundPicUri;
  final List<dynamic>? commentDetailDto;
  final List<dynamic>? postHashes;

  postcardDetail({
    required this.content,
    required this.postTime,
    required this.location,
    required this.postLikeCnt,
    required this.postLikeResult,
    required this.commentCnt,
    required this.backgroundPicUri,
    required this.commentDetailDto,
    required this.postHashes,
  });

  factory postcardDetail.fromJson(Map<String, dynamic> json) {
    return postcardDetail(
      content: json["content"],
      postTime: json["postTime"],
      location: json["location"],
      postLikeCnt: json["postLikeCnt"],
      postLikeResult: json["likeResult"] ?? false,
      commentCnt: json["commentCnt"],
      backgroundPicUri: json["backgroundPicUri"],
      commentDetailDto: json["commentDetailDto"],
      postHashes: json["postHashes"],
    );
  }
}
