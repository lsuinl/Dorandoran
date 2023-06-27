import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//회원가입: 데이터 전송 500
Future<String> postUserRequest(String dateOfBirth, String nickName, String firebasetoken,
    String kakaoAccessToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var response = await http.post(
    Uri.parse('$urls/api/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "dateOfBirth": dateOfBirth,
      "nickName": nickName,
      "firebaseToken": firebasetoken,
      "kakaoAccessToken": kakaoAccessToken
    }),
  );
  print(response.statusCode);
  Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  prefs.setString("nickName", body["nickName"].toString());
  prefs.setString("email", body["email"].toString());
  prefs.setString("accessToken", body["tokenDto"]!["accessToken"].toString()); //액세스토큰:첫번쨰에있음
  prefs.setString("refreshToken", body["tokenDto"]!["refreshToken"].toString());
  // userinformation body = userinformation.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  // prefs.setString("email", body.email);
  // prefs.setString("nickname", body.nickName);
  // prefs.setString("accessToken", body.tokenDto![0]); //액세스토큰:첫번쨰에있음
  // prefs.setString("refreshToken", body.tokenDto![1]);

  return response.body;
}
