import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/quest_token.dart';
import '../../texting/home/model/postcard.dart';

//알림 읽음 표시하기
Future<int> GetReadNotice(int notificationId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.get(
    Uri.parse('$urls/api/post/member/like/$notificationId'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
  );
  print(response.body);
  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  return response.statusCode;
}
