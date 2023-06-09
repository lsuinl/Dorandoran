import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

import '../../../common/storage.dart';

//대댓글삭제하기
Future<int>  deletecomment(int commentId, String userEmail) async {
  http.Response response=  await http.post(
    Uri.parse('$url/api/comment-delete'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $refreshToken',
    },
    body: jsonEncode({
      "commentId":commentId,
      "userEmail":userEmail,
    }),
  );
  print(commentId);
  print(userEmail);
  print(response.statusCode);
  return response.statusCode;
}