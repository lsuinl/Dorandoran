import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

//좋아요
void postLike(int postId, String email) async {
  http.Response respon= await http.post(
    Uri.parse('$url/api/post-like'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "postId":postId,
      "email": email,
    }),
  );
  print(respon.statusCode);
}