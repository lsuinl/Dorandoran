import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
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


Future<int> registered(String email) async {
  var response = await http.post(
    Uri.parse('$url/api/check/registered'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "email":email
    }),
  );
  if(response.statusCode==200) {
    userinformation body = userinformation.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString("email", body.email);
    prefs.setString("nickname", body.nickName);
  }
  return response.statusCode;
}
