import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//댓글달기
Future<DateTime> PostComment(int postId, String comment, bool anonymity, bool secretMode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.post(
    Uri.parse('$urls/api/comment'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "postId":postId,
      "comment": comment,
      "anonymity":anonymity,
      "secretMode": secretMode
    }),
  );
  if(response.statusCode==401){
    int number=await quest_token();
    if(number==200)
      return PostComment(postId, comment, anonymity, secretMode);
  }
  return DateTime.now();
}