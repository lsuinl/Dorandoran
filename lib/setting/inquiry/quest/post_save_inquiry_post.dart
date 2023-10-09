import 'dart:convert';
import 'package:dorandoran/common/model/all_notification_model.dart';
import 'package:dorandoran/common/uri.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/quest_token.dart';

//문의글 작성하기
Future<int> PostSaveInquiryPost(String title, String content) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response = await http.post(
    Uri.parse('$urls/api/inquiryPost'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization': 'Bearer $accessToken',
    },
    body: jsonEncode({
      "title":title,
      "content": content
    }),
  );
  if (response.statusCode == 401) {
    int number = await quest_token();
    if (number == 200)
      return PostSaveInquiryPost(title, content);
  }
  return response.statusCode;
}