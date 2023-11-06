class noticeModel {
  final int notificationId;
  final String title;
  final String message;
  final String notificationTime;
  final bool isRead;
  final String notificationType;

  noticeModel({
    required this.notificationId,
    required this.title,
    required this.message,
    required this.notificationTime,
    required this.isRead,
    required this.notificationType,
  });
  factory noticeModel.fromJson(Map<String, dynamic> json) {
    return noticeModel(
      notificationId: json["notificationId"],
      title: json["title"],
      message: json["message"],
      notificationTime: json["notificationTime"],
      isRead: json["isRead"],
      notificationType: json["notificationType"],
    );
  }
}