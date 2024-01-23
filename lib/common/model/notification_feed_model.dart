class NotificationFeedModel {
  final String title;
  final String content;
  final String createdTime;
  final int notificationId;

  NotificationFeedModel({
    required this.title,
    required this.content,
    required this.createdTime,
    required this.notificationId,
  });
  factory NotificationFeedModel.fromJson(Map<String, dynamic> json) {
    return NotificationFeedModel(
        title: json["title"],
        content: json['content'],
        createdTime: json["createdTime"],
        notificationId: json["notificationId"]
    );
  }
}
