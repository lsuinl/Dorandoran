import 'package:dorandoran/common/quest_token.dart';
import 'package:dorandoran/texting/post_datail/model/postcard_detaril.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//세부 글 가져오기
Future<postcardDetail> PostPostDetail(
    int postId, String location) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;

  var response = await http.post(
    Uri.parse('$urls/api/post/detail'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "postId": postId,
      "location": location
    }),
  );
  print(response.body);
  if(response.statusCode==401){
    quest_token();
    PostPostDetail(postId, location);
  }
  Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  postcardDetail card = postcardDetail.fromJson(body);
  return card;
}
