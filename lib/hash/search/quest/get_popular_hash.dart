import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/quest_token.dart';
import '../model/popular_hash.dart';

//인기 해시태그 가져오기
Future<List<popularHash>> GetPopularHash() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.get(
    Uri.parse('$urls/api/hashTag/popular'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
  );
  if(response.statusCode==401){
    int number=await quest_token();
    if(number==200) {
      return GetPopularHash();
    }
  }
  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  List<popularHash> card = body.map((dynamic e) => popularHash.fromJson(e)).toList();
  return card;
}
