import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//대댓글삭제하기
Future<int>  deletepost(int postId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String email = prefs.getString("email")!;
  try {
    http.Response response = await http.post(
      Uri.parse('$urls/api/post-delete'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "postId": postId,
        "userEmail": email,
      }),
    );
    print(response.statusCode);
    return response.statusCode;
  }
  catch(e){
    quest_token();
    deletepost(postId);
    return 400;
  }
}