import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/quest_token.dart';

//알림 개수 체크
Future<dynamic> GetCount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response = await http.get(
    Uri.parse('$urls/api/notification/count'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization': 'Bearer $accessToken',
    },
  );
  if (response.statusCode == 401) {
    int number = await quest_token();
    if (number == 200)
      return GetCount();
  }
  else {
    print("안녕");
    print(response.body);
    dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
    return body['remainCount'];
  }
}