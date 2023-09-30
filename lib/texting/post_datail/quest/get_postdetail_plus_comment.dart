import 'package:dorandoran/common/quest_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/commentcard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

//댓글 더보기
Future<dynamic> GetCommentPlus(int postid,int commentid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  var response = await http.get(
    Uri.parse('${urls}/api/comment?postId=${postid}&commentId=${commentid}'),
    headers: <String, String>{
      'authorization':'Bearer $accessToken',
    },
  );
  if(response.statusCode==401) {
    int number=await quest_token();
    if(number==200)
      return GetCommentPlus(postid, commentid);
  }
  else {

    List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
    List<commentcard> card = body.map((dynamic e) => commentcard.fromJson(e))
        .toList();
    return card;
  }
}
