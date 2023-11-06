import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/quest_token.dart';
import '../../texting/home/model/postcard.dart';

//내가 쓴 글 보기
Future<dynamic> GetAllPosts(int number) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response = await http.get(
    Uri.parse('$urls/api/post/member/$number'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization': 'Bearer $accessToken',
    },
  );
  if (response.body == []) {
    return GetAllPosts(number - 1);
  }
  else if (response.statusCode == 401) {
    int number = await quest_token();
    if (number == 200)
      return GetAllPosts(number);
  }
  else {
    print(response.body);
    List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
    List<postcard> card = body.map((dynamic e) => postcard.fromJson(e))
        .toList();
    return card;
  }
}