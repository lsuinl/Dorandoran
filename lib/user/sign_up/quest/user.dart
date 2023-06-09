import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/storage.dart';

class userinformation {
  final String email;
  final String nickName;

  userinformation({
    required this.email,
    required this.nickName,
  });
  factory userinformation.fromJson(Map<String, dynamic> json) {
    return userinformation(
        email: json["email"],
        nickName: json["nickName"]
    );
  }
}
//회원가입: 데이터 전송 500
Future<String> postUserRequest(String dateOfBirth, String nickName, String firebasetoken,
    String kakaoAccessToken) async {
  var response = await http.post(
    Uri.parse('$url/api/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $refreshToken',
    },
    body: jsonEncode({
      "dateOfBirth": dateOfBirth,
      "nickName": nickName,
      "firebaseToken": firebasetoken,
      "kakaoAccessToken": kakaoAccessToken
    }),
  );

  userinformation body = userinformation.fromJson(
      jsonDecode(utf8.decode(response.bodyBytes)));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.setString("email", body.email);
  prefs.setString("nickname", body.nickName);
  return response.body;
}
