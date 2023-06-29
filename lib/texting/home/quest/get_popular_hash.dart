import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//인기 해시태그 가져오기
Future<List<String>> GetPopularHash() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.get(
    Uri.parse('$urls/api/hashTag-popular'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
  );
  Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  List<String> names = List<String>.from(body["hashTagList"]);
  return names;
}