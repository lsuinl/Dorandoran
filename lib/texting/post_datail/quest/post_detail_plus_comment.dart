import 'package:dorandoran/common/quest_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/commentcard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

//글 가져오기
Future<List<commentcard>> PlusComment(
    int postid,int commentid,String userEmail) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  var response = await http.get(
    Uri.parse('${url}/api/comment?postId=${postid}&commentId=${commentid}&userEmail=${userEmail}'),
    headers: <String, String>{
      'authorization':'Bearer $accessToken',
    },
  );
  if(response.statusCode==401){
    quest_token();
    PlusComment(postid, commentid, userEmail);
  }
  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  List<commentcard> card = body.map((dynamic e) => commentcard.fromJson(e)).toList();
  return card;
}
