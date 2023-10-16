import 'dart:convert';
import 'package:dorandoran/common/model/notification_model.dart';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/quest_token.dart';


//홈화면 기본 공지
Future<dynamic> GetHomeNotification() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response = await http.get(
    Uri.parse('$noticeUrls/api/notification/home'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization': 'Bearer $accessToken',
    },
  );
  if (response.body == []) {
    return null;
  }
  else if (response.statusCode == 401) {
    int number = await quest_token();
    if (number == 200)
      return GetHomeNotification();
  }
  else {
    dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
    NotificationModel message =  NotificationModel.fromJson(body[0]);
    return message;
  }
}