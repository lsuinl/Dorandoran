import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/quest_token.dart';
import '../model/search_hash.dart';

//해시태그 검색창
Future<List<searchHash>> GetSearchHash(String text) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String encodeurl = Uri.encodeFull('$urls/api/hashTag?hashTag=$text');
  http.Response response= await http.get(
    Uri.parse(encodeurl),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
  );
  if(response.statusCode==401){
    int number=await quest_token();
    if(number==200)
      return GetSearchHash(text);
  }
    List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
    List<searchHash> card = body.map((dynamic e) => searchHash.fromJson(e))
        .toList();
    return card;


}
