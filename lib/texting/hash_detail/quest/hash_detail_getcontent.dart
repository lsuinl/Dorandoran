import 'package:dorandoran/common/quest_token.dart';
import 'package:dorandoran/texting/home/model/postcard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

//글 가져오기
Future<List<postcard>> getHashContent(
    String tagname, int number) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String userEmail=prefs.getString("email")!;
  //위치정보를 받아오지 못한경우. 0으로 전송?
  String location="${prefs.getString("latitude")??"123"},${prefs.getString("longtitude")??"123"}";
  var response = await http.get(
    Uri.parse(
        '${urls}/api/hashtag/${tagname}/${number}/${location}'),
    headers: <String, String>{
      'authorization':'Bearer $accessToken',
    },
  );
  print(response.statusCode);
  if (response.body==[]) {
    getHashContent(tagname, number - 1);
  }
  else if(response.statusCode==401){
    quest_token();
    getHashContent(tagname, number);
  }

  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  List<postcard> card = body.map((dynamic e) => postcard.fromJson(e)).toList();
  return card;
}
