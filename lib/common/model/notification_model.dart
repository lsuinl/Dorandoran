class NotificationModel {
  final String title;
  final String content;
  final String createdTime;

  NotificationModel({
    required this.title,
    required this.content,
    required this.createdTime,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        title: json["title"],
        content: json["content"],
        createdTime: json["createdTime"]
    );
  }
}
