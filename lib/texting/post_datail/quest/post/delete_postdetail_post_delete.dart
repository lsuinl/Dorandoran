import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//글 삭제하기
Future<int>  DeletePostDelete(int postId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  try {
    http.Response response = await http.delete(
      Uri.parse('$urls/api/post'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "postId": postId,
      }),
    );
    return response.statusCode;
  }
  catch(e){
    quest_token();
    int number=await quest_token();
    if(number==200)
      return DeletePostDelete(postId);
    return 400;
  }
}