class postcard {
  final int postId;
  final String contents;
  final String postTime;
  final int? location;
  final int likeCnt;
  final bool likeResult;
  final String backgroundPicUri;
  final int? replyCnt;

  postcard({
    required this.postId,
    required this.contents,
    required this.postTime,
    required this.location,
    required this.likeCnt,
    required this.likeResult,
    required this.backgroundPicUri,
    required this.replyCnt,
  });

  factory postcard.fromJson(Map<String, dynamic> json) {
    return postcard(
      postId: json["postId"],
      contents: json["contents"],
      postTime: json["postTime"],
      location: json["location"],
      likeCnt: json["likeCnt"],
      likeResult: json["likeResult"],
      backgroundPicUri: json["backgroundPicUri"],
      replyCnt: json["replyCnt"],
    );
  }
}
