import 'dart:convert';
import 'package:dorandoran/notice/model/notice_model.dart';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/quest_token.dart';

//알림 읽음처리하기
Future<dynamic> PatchReadNotice(List<int> lists) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.patch(
    Uri.parse('$urls/api/notification'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "notifcationList":lists,
    })
  );
  return response.statusCode;
}
