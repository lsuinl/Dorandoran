import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//신고하기-댓글
Future<int> PostReportComment(int commentid,String reportContent) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.post(
    Uri.parse('$urls/api/comment/report'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "commentId":commentid,
      "reportContent": reportContent,
    }),
  );

  print(response.statusCode);
  return response.statusCode;
}