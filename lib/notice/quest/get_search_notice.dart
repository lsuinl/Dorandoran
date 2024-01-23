import 'dart:convert';
import 'package:dorandoran/notice/model/notice_model.dart';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/quest_token.dart';

//알림 전체 조회하기
Future<dynamic> GetSearchNotice(int number) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.get(
    Uri.parse('$urls/api/notification/$number'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
  );
  if(response.body==[]) {
    return [];
  }
  if(response.statusCode==401) {
    int number = await quest_token();
    if (number == 200) {
      return GetSearchNotice(number);
    }
  }
  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  List<noticeModel> card = body.map((dynamic e) => noticeModel.fromJson(e)).toList();
  return card;
}
