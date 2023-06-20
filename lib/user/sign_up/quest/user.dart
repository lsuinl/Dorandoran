import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dorandoran/user/model/userinformation.dart';

//회원가입: 데이터 전송 500
Future<String> postUserRequest(String dateOfBirth, String nickName, String firebasetoken,
    String kakaoAccessToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  var response = await http.post(
    Uri.parse('$url/api/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "dateOfBirth": dateOfBirth,
      "nickName": nickName,
      "firebaseToken": firebasetoken,
      "kakaoAccessToken": kakaoAccessToken
    }),
  );
  print(response.statusCode);
  userinformation body = userinformation.fromJson(
      jsonDecode(utf8.decode(response.bodyBytes)));
  //prefs.setString("email", body.email);
  prefs.setString("nickname", body.nickName);
  prefs.setString("accessToken", body.tokenDto![0]); //액세스토큰:첫번쨰에있음
  prefs.setString("refreshToken", body.tokenDto![1]);

  return response.body;
}
