import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/quest_token.dart';

//대댓글삭제하기
Future<int>  deletecomment(int commentId, String userEmail) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response=  await http.post(
    Uri.parse('$url/api/comment-delete'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "commentId":commentId,
      "userEmail":userEmail,
    }),
  );
  if(response.statusCode==401){
    quest_token();
    deletecomment(commentId, userEmail);
  }
  print(commentId);
  print(userEmail);
  print(response.statusCode);
  return response.statusCode;
}