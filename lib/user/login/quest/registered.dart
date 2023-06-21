import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dorandoran/user/model/userinformation.dart';

Future<int> registered(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")??""; //아마이럴일은없지만

  var response = await http.post(
    Uri.parse('$url/api/check/registered'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "email":email
    }),
  );
  if(response.statusCode==200) { //이미가입된 회원이면 회원정보저장하기
    userinformation body = userinformation.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString("email", body.email);
    prefs.setString("nickname", body.nickName);
    return 200;
  }
  else if(response.statusCode==401){
    quest_token();
    registered(email);
    return 401;
  }
  else return 400;

}
