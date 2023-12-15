import 'dart:convert';

import 'package:dorandoran/common/uri.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/quest_token.dart';

//알림 기능 여부 조회하기
Future<bool> GetNotice() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response = await http.get(
    Uri.parse('$urls/api/notificationStatus'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization': 'Bearer $accessToken',
    },
  );
  print(response.statusCode);
  if (response.statusCode == 401) {
    int number = await quest_token();
    if (number == 200)
      return GetNotice();
  }
  dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
  bool check = body['notificationStatus'];
  print(body['notificationStatus']);
  return check;
}