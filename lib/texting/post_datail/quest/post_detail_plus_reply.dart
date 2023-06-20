import 'package:dorandoran/common/quest_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

import '../model/replycard.dart';
//글 가져오기
Future<List<replycard>> PlusReply(
    int postid,int commentid,int replyid, String userEmail) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  var response = await http.get(
    Uri.parse('${url}/api/reply?postId=${postid}&commentId=${commentid}&replyId=${replyid}&userEmail=${userEmail}'),
      headers: <String, String>{
        'authorization':'Bearer $accessToken',
      },
    );
  if(response.statusCode==401){
    quest_token();
    PlusReply(postid, commentid, replyid, userEmail);
  }
  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  List<replycard> card = body.map((dynamic e) => replycard.fromJson(e)).toList();
  return card;
}
