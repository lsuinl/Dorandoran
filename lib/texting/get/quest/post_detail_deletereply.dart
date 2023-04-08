import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

//대댓글삭제하기
Future<int>  deletereply(int replyId, String userEmail) async {
  http.Response response=  await http.post(
    Uri.parse('$url/api/reply-delete'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "replyId":replyId,
      "userEmail":userEmail,
    }),
  );
  print(replyId);
  print(userEmail);
  print(response.statusCode);
  return response.statusCode;
}