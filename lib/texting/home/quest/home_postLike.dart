import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//좋아요
void postLike(int postId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String email = prefs.getString("email")!;
  http.Response respon= await http.post(
    Uri.parse('$urls/api/post-like'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "postId":postId,
      "email": email,
    }),
  );
  print(respon.statusCode);
}