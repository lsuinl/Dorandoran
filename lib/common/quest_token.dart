import 'dart:convert';
import 'package:http/http.dart'as http;
import 'uri.dart';
import 'storage.dart';

//refresh 토큰으로 acctoken요청하기
Future<String> quset_token(String refreshtoken) async {

  var response = await http.post(
    Uri.parse('$url/api/check/registered'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $refreshToken',
    },
    body: jsonEncode({
      'refreshtoken':refreshtoken
    }),
  );

  return response.body;
}
