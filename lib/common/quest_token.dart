import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'uri.dart';


//refresh 토큰으로 accesstoken=토큰재발급
Future<int> quest_token() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String accessToken = prefs.getString("accessToken")!;
  // String refreshToken = prefs.getString("refreshToken")!;
  // var response = await http.patch(
  //   Uri.parse('$urls/api/token'),
  //   headers: <String, String>{
  //     'Content-Type': 'application/json',
  //   },
  //   body: jsonEncode({
  //     'refreshToken':refreshToken,
  //     'accessToken':accessToken
  //   }),
  // );
  // if(response.statusCode==200) {//재대로 받은 경우에만 변경
  //   Map<String,dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  //   prefs.setString("accessToken", body["accessToken"].toString());
  // }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String refreshToken = prefs.getString("refreshToken")!;
  var response = await http.patch(
    Uri.parse('$urls/api/test/token'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'refreshToken':refreshToken,
      'limitTime':5000,
    }),
  );
  print("엑세스");
  if(response.statusCode==200) {//재대로 받은 경우에만 변경
    prefs.setString("accessToken", response.body);
    // Map<String,dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
    // prefs.setString("accessToken", body["accessToken"].toString());
  }
  return 200;
}
