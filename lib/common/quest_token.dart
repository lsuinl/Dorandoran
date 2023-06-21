import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'uri.dart';

// class token_zip {
//   final String? refreshToken;
//   final String? accessToken;
//
//   token_zip({
//     required this.refreshToken,
//     required this.accessToken,
//   });
//
//   factory token_zip.fromJson(Map<String, dynamic> json) {
//     return token_zip(
//         refreshToken: json["refreshToken"],
//         accessToken: json["accessToken"]);
//   }
// }

//refresh 토큰으로 accesstoken=토큰재발급
Future<String> quest_token() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String refreshToken = prefs.getString("refreshToken")!;
  var response = await http.post(
    Uri.parse('$url/api/token'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'refreshToken':refreshToken,
      'accessToken':accessToken
    }),
  );
  Map<String,dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  prefs.setString("accessToken", body["accessToken"].toString());
  return response.body;
}
