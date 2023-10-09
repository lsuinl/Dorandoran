import 'dart:convert';
import 'package:dorandoran/common/model/all_notification_model.dart';
import 'package:dorandoran/common/uri.dart';
import 'package:dorandoran/setting/inquiry/model/inquiry_detail_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/quest_token.dart';

//문의글 상세보기
Future<dynamic> GetReadInquiryPost(int number) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response = await http.get(
    Uri.parse('$urls/api/inquiryPost/$number/read'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization': 'Bearer $accessToken',
    },
  );
  if (response.statusCode == 401) {
    int number = await quest_token();
    if (number == 200)
      return GetReadInquiryPost(number);
  }
  else {
    dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
    print(body);
    InquiryDetailModel card = InquiryDetailModel.fromJson(body);
    return card;
  }
}