import '../model/commentcard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:dorandoran/texting/get/model/replycard.dart';
//글 가져오기
Future<List<replycard>> PlusReply(
    int postid,int commentid,int replyid, String email) async {
  var response = await http.get(
    Uri.parse('${url}/api/reply?postId=${postid}&commentId=${commentid}&replyId=${replyId}&userEmail=${userEmail}'),
  );
  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  List<replycard> card = body.map((dynamic e) => replycard.fromJson(e)).toList();
  print(card)
  return card;
}
