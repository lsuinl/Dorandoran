import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../texting/home/model/postcard.dart';

//내 해시태그 글 가져오기
Future<dynamic> GetMyHashContent() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.get(
    Uri.parse('$urls/api/post/interested'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
  );
  if(response.statusCode==401)
    return response.statusCode;
  if(response.body.length<1) {
    return [];
  }
  else{
    List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
    print(body);
    List<postcard> cards=List<postcard>.from(body[0].values.map((dynamic e) => postcard.fromJson(e)).toList());
    return cards;
  }
}