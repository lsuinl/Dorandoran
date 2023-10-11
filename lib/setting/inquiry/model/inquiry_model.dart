class InquiryModel {
  final int inquiryPostId;
  final String title;
  final String createTime;
  final String inquiryStatus;

  InquiryModel({
    required this.inquiryPostId,
    required this.title,
    required this.createTime,
    required this.inquiryStatus,
  });
  factory InquiryModel.fromJson(Map<String, dynamic> json) {
    return InquiryModel(
        inquiryPostId: json["inquiryPostId"],
        title: json["title"],
        createTime: json["createTime"],
        inquiryStatus: json["inquiryStatus"],
     );
  }
}
