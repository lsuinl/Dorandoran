import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//신고하기-글
Future<int> PostReportPost(int postid,String reportContent) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.post(
    Uri.parse('$urls/api/post/report'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "postId":postid,
      "reportContent": reportContent,
    }),
  );

  print(response.statusCode);
  return response.statusCode;
}