import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//대댓글삭제하기
Future<int>  deletereply(int replyId, String userEmail) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response=  await http.post(
    Uri.parse('$url/api/reply-delete'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "replyId":replyId,
      "userEmail":userEmail,
    }),
  );
  if(response.statusCode==401){
    quest_token();
    deletereply(replyId, userEmail);
  }
  print(replyId);
  print(userEmail);
  print(response.statusCode);
  return response.statusCode;
}