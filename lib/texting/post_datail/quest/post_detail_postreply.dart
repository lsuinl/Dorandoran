import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

import '../../../common/storage.dart';

//대댓글달기만드는중
Future<DateTime>  postreply(int commentId, String userEmail, String reply, bool anonymity, bool secretMode) async {
  http.Response response=  await http.post(
    Uri.parse('$url/api/reply'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $refreshToken',
    },
    body: jsonEncode({
      "commentId":commentId,
      "userEmail":userEmail,
      "reply": reply,
      "anonymity":anonymity,
      "secretMode": secretMode
    }),
  );
  return DateTime.now();
}