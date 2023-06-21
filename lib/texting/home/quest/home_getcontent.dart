import 'package:dorandoran/common/quest_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/postcard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

//글 가져오기
Future<List<postcard>> getPostContent(
    String? urls, String? userEmail, int number, String? location) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? accessToken = prefs.getString("accessToken");
  var response = await http.get(
    Uri.parse(
        '${url}/api/post${urls ?? ""}?userEmail=${userEmail}&postCnt=${number}&location=${location}'),
      headers: <String, String>{
        'authorization':'Bearer $accessToken',
      },
    );
  print(response.statusCode);
  if (response.body==[]) {
    getPostContent(urls, userEmail, number - 1, location);
  }
  else if(response.statusCode==401){
    quest_token();
    getPostContent(urls, userEmail, number, location);
  }
  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  List<postcard> card = body.map((dynamic e) => postcard.fromJson(e)).toList();
  return card;
}
