import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/quest_token.dart';
import '../../../common/model/notification_model.dart';


//공지 목록 보기
Future<dynamic> GetCriticalNotification() async {
  http.Response response = await http.get(
    Uri.parse('$noticeUrls/api/notification/critical'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
  print(response.statusCode);
    if(response.statusCode==201 || response.statusCode==200) {
      dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
      NotificationModel message =  NotificationModel.fromJson(body[0]);
      return message;
    }
    else{
      return response.statusCode;
    }
}