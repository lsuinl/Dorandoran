import 'package:dorandoran/common/quest_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import '../../model/replycard.dart';

//대댓글 더보기
Future<dynamic> GetReplyPlus(
    int postid,int commentid,int replyid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  var response = await http.get(
    Uri.parse('${urls}/api/reply?postId=${postid}&commentId=${commentid}&replyId=${replyid}'),
      headers: <String, String>{
        'authorization':'Bearer $accessToken',
      },
    );
  print(response.body);
  if(response.statusCode==401) {
    int number = await quest_token();
    if(number==200)
      return GetReplyPlus(postid, commentid, replyid);
  }
  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  return body[0];
}
