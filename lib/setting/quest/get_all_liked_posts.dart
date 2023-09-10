import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/quest_token.dart';
import '../../texting/home/model/postcard.dart';

//내가 좋아요 한 글 가져오기
Future<dynamic> GetAllLikedPosts(int number) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.get(
    Uri.parse('$urls/api/post/member/like/$number'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
  );
  print(response.body);
  if (response.body==[]) {
    GetAllLikedPosts(number - 1);
  }
  else if(response.statusCode==401)
    return response.statusCode;

  print(response.body);
  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  List<postcard> card = body.map((dynamic e) => postcard.fromJson(e)).toList();
  return card;
}
