import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//좋아요
void commentLike(int postId,int commentId, String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  var response= await http.post(
    Uri.parse('$url/api/comment-like'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "postId":postId,
      "commentId":commentId,
      "userEmail": email,
    }),
  );
  if(response.statusCode==401){
    quest_token();
    commentLike(postId, commentId, email);
  }
}