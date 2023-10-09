import 'dart:convert';
import 'package:dorandoran/common/model/all_notification_model.dart';
import 'package:dorandoran/common/uri.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/quest_token.dart';

//문의글 삭제하기
Future<int> DelInquiryPost(int number) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response = await http.delete(
    Uri.parse('$urls/api/inquiryPost/$number'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization': 'Bearer $accessToken',
    },
  );
  if (response.statusCode == 401) {
    int number = await quest_token();
    if (number == 200)
      return DelInquiryPost(number);
  }
  return response.statusCode;
}