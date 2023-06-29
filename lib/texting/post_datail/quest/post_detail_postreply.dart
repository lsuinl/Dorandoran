import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//대댓글달기
Future<DateTime>  postreply(int commentId, String reply, bool anonymity, bool secretMode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String email = prefs.getString("email")!;
  http.Response response=  await http.post(
    Uri.parse('$urls/api/reply'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "commentId":commentId,
      "userEmail":email,
      "reply": reply,
      "anonymity":anonymity,
      "secretMode": secretMode
    }),
  );
  if(response.statusCode==401){
    quest_token();
    postreply(commentId, reply, anonymity, secretMode);
  }
  return DateTime.now();
}