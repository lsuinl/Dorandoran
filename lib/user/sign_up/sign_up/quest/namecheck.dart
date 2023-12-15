import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//사용가능닉네임 statusCode:200, 불가능닉네임 statusCode:400
Future<int> postNameCheckRequest(
    String nickName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //String publicKey = prefs.getString("Public-Key")!;
  var response = await http.post(
    Uri.parse('$urls/api/nickname'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "nickname": nickName,
    }),
  );
  print(response.body);
  return response.statusCode;
}

