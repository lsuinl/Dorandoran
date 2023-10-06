import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/quest_token.dart';
import '../../../common/model/notification_model.dart';


//공지 목록 보기
Future<dynamic> GetCriticalNotification() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  http.Response response = await http.get(
    Uri.parse('http://116.44.231.155:8081/api/notification/critical'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
  if (response.body == []) {
    return [];
  }
  else if (response.statusCode == 401) {
    int number = await quest_token();
    if (number == 200)
      return GetCriticalNotification();
  }
  else {
    dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
    print(body);
    NotificationModel message =  NotificationModel.fromJson(body[0]);
    return message;
  }
}