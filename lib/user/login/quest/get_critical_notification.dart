import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/quest_token.dart';


//공지 목록 보기
Future<dynamic> GetCriticalNotification() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response = await http.get(
    Uri.parse('$urls/api/notification/all'),
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
      return GetCriticalNotification();
  }
  else {
    print(response.body);
    List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
    //리스트 변환? 또는 그대로
    return body;
  }
}