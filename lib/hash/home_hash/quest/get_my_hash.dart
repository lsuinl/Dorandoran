import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//내가 추가한 해시태그 목록 가져오기
Future<dynamic> GetMyHash() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.get(
    Uri.parse('$urls/api/hashTag/member'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
  );
  List<String> names = [];
  if(response.statusCode==401)
    return response.statusCode;
  if(response.body.length<1)
    return names;
  else {
   Map<String,dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
   print(body);
    names = List<String>.from(body["hashTagList"]);
    return names;
  }
}
