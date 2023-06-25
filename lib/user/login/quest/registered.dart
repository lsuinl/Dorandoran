import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int> registered() async {
try {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = prefs.getString("email")!;
  var response = await http.post(
    Uri.parse('$urls/api/check/registered'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "email": email
    }),
  );
  //이미가입된 회원이면 회원정보저장하기

  Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  prefs.setString("accessToken", body["tokenDto"]!["accessToken"].toString()); //액세스토큰:첫번쨰에있음
  prefs.setString("refreshToken", body["tokenDto"]!["refreshToken"].toString());
  print(prefs.getString("accessToken"));
  print(prefs.getString("refreshToken"));
    return 200;
}
catch(e){
  print(e);
  return 400;
}

}
