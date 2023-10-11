class InquiryDetailModel {
  final int inquiryPostId;
  final String memberEmail;
  final String title;
  final String content;
  final String postCreateTime;
  final List<dynamic> inquiryCommentList;

  InquiryDetailModel({
    required this.inquiryPostId,
    required this.memberEmail,
    required this.title,
    required this.content,
    required this.postCreateTime,
    required this.inquiryCommentList,
  });
  factory InquiryDetailModel.fromJson(Map<String, dynamic> json) {
    return InquiryDetailModel(
        inquiryPostId: json["inquiryPostId"],
        memberEmail: json["memberEmail"],
        title: json["title"],
        content: json["content"],
        postCreateTime: json["postCreateTime"],
        inquiryCommentList: json["inquiryCommentList"]);
  }
}
