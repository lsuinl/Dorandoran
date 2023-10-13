import 'package:dorandoran/common/quest_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//대댓글삭제하기
Future<int>  DeleteReplyDelete(int replyId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  try {
    http.Response response = await http.delete(
      Uri.parse('$urls/api/reply'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "replyId": replyId,
      }),
    );
    print(replyId);
    print(response.statusCode);
    return response.statusCode;
  }
  catch(e){
      int number=await quest_token();
      if(number==200)
        return DeleteReplyDelete(replyId);
      return 400;
  }
}