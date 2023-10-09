import 'dart:convert';
import 'package:dorandoran/common/model/all_notification_model.dart';
import 'package:dorandoran/common/model/notification_model.dart';
import 'package:dorandoran/common/uri.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/quest_token.dart';

//공지 상세보기
Future<dynamic> GetDetailNotification(int number) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response = await http.get(
    Uri.parse('$noticeUrls/api/notification/$number'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization': 'Bearer $accessToken',
    },
  );
  if (response.body == []) {
    return [];
  }
  else if (response.statusCode == 401) {
    int number = await quest_token();
    if (number == 200)
      return GetDetailNotification(number);
  }
  else {
    dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
    print(response.body);
    NotificationModel card = NotificationModel.fromJson(body);
    //리스트 변환? 또는 그대로
    return card;
  }
}