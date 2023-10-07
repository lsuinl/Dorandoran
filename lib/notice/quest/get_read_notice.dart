import 'dart:convert';
import 'package:dorandoran/notice/model/read_notice_model.dart';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/quest_token.dart';
import '../../texting/home/model/postcard.dart';

//알림 읽으러가기
Future<dynamic> GetReadNotice(int notificationId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.get(
    Uri.parse('$urls/api/notification/$notificationId/detail'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
  );
  print(response.body);
  dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
  ReadNoticeModel card =  ReadNoticeModel.fromJson(body);

  return card;
}
