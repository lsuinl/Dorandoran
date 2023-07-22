import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//대댓글삭제하기
Future<int>  PostReplyDelete(int replyId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String email = prefs.getString("email")!;
  try {
    http.Response response = await http.post(
      Uri.parse('$urls/api/reply-delete'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "replyId": replyId,
        "userEmail": email,
      }),
    );
    print(replyId);
    print(email);
    print(response.statusCode);
    return response.statusCode;
  }
  catch(e){
    quest_token();
    PostReplyDelete(replyId);
    return 400;
  }
}