import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/quest_token.dart';

//대댓글삭제하기
Future<int>  deletecomment(int commentId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String email = prefs.getString("email")!;
  try {
  http.Response response=  await http.post(
    Uri.parse('$urls/api/comment-delete'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "commentId":commentId,
      "userEmail":email,
    }),
  );
  print(commentId);
  print(email);
  print(response.statusCode);
  return response.statusCode;
  }
  catch(e) {
    quest_token();
    deletecomment(commentId);
    return 400;
  }
}