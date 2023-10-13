import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/quest_token.dart';

//댓글삭제하기
Future<int>  DeleteCommentDelete(int commentId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  try {
  http.Response response=  await http.delete(
    Uri.parse('$urls/api/comment'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
    body: jsonEncode({
      "commentId":commentId,
    }),
  );
  print(commentId);
  print(response.statusCode);
  return response.statusCode;
  }
  catch(e) {
      int number=await quest_token();
      if(number==200)
        return DeleteCommentDelete(commentId);
    return 400;
  }
}