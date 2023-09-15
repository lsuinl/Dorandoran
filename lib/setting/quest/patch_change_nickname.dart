import 'dart:convert';
import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//닉네임 변경하기
Future<int> PatchChangeNickname(String nickname) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.patch(
    Uri.parse('$urls/api/nickname'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body:  jsonEncode({
      "nickname":nickname,
    }),
  );
  prefs.setString("nickname", nickname);
  if(response.statusCode==401){
    int number=await quest_token();
    if(number==200)
      PatchChangeNickname(nickname);
  }
  print(response.statusCode);
  return response.statusCode;
}
