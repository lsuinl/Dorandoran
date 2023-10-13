import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//차단하기
Future<int> PostBlockMember(String blockType,int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.post(
    Uri.parse('$urls/api/member/block'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "blockType":blockType,
      "id": id,
    }),
  );
  if(response.statusCode==401){
    int number = await quest_token();
    if(number==200)
      return PostBlockMember(blockType, id);
  }
  print(response.statusCode);
  return response.statusCode;
}