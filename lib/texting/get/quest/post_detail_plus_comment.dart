import '../model/commentcard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

//글 가져오기
Future<List<CommentCard>> PlusComment(
    int postid,int commentid,String userEmail) async {
  var resonse = await http.get(
    Uri.parse(
        '${posturl}/api/comment?postId=${postid}&commentId=${commentid}&userEmail=${userEmail}'),
  );
  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  List<CommentCard> card = body.map((dynamic e) => CommentCard.fromJson(e)).toList();
  print(card);
  return card;
}
