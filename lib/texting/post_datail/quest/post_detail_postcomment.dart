import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

import '../../../common/storage.dart';

//대댓글달기만드는중
Future<DateTime> postcomment(int postId, String email, String comment, bool anonymity, bool secretMode) async {
  http.Response response= await http.post(
    Uri.parse('$url/api/comment'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $refreshToken',
    },
    body: jsonEncode({
      "postId":postId,
      "email":email,
      "comment": comment,
      "anonymity":anonymity,
      "secretMode": secretMode
    }),
  );
  return DateTime.now();
}