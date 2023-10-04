class AllNotificationModel {
  final String title;
  final String createdTime;
  final int notificationId;

  AllNotificationModel({
    required this.title,
    required this.createdTime,
    required this.notificationId,
  });
  factory AllNotificationModel.fromJson(Map<String, dynamic> json) {
    return AllNotificationModel(
        title: json["title"],
        createdTime: json["createdTime"],
        notificationId: json["notificationId"]
    );
  }
}
