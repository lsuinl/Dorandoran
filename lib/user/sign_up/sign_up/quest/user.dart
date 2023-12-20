import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

//회원가입: 데이터 전송 500
Future<String> postUserRequest(String dateOfBirth, String nickname) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String ostype = prefs.getString("ostype")!;
  String firebasetoken = prefs.getString("firebasetoken")!;
  String kakaoAccessToken = prefs.getString("kakaotoken")!;
  bool notifyStatus = await Permission.notification.isGranted;
  var response = await http.post(
    Uri.parse('$urls/api/member'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "dateOfBirth": dateOfBirth,
      "nickname": nickname,
      "firebaseToken": firebasetoken,
      "kakaoAccessToken": kakaoAccessToken,
      "osType": ostype,
      "notifyStatus":notifyStatus
    }),
  );
  Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  prefs.setString("nickname", body["nickname"].toString());
  prefs.setString("email", body["email"].toString());
  prefs.setString("accessToken", body["tokenDto"]!["accessToken"].toString());
  prefs.setString("refreshToken", body["tokenDto"]!["refreshToken"].toString());
  return response.body;
}
