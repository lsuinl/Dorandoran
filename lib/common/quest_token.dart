import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'uri.dart';


//refresh 토큰으로 accesstoken=토큰재발급
void quest_token() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String refreshToken = prefs.getString("refreshToken")!;
  var response = await http.post(
    Uri.parse('$urls/api/token'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'refreshToken':refreshToken,
      'accessToken':accessToken
    }),
  );
  print(response.body);
  if(response.body.isNotEmpty) {
    Map<String,dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
    prefs.setString("accessToken", body["accessToken"].toString());
  }
}
