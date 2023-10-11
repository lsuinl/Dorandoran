import 'dart:convert';
import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//다시보지않기
Future<int> PatchRejectHomeNotification() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.patch(
    Uri.parse('$noticeUrls/api/notification/reject/home'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
  );
  print(response.statusCode);
  if(response.statusCode==401){
    int number=await quest_token();
    if(number==200)
      PatchRejectHomeNotification();
  }
  return response.statusCode;
}
