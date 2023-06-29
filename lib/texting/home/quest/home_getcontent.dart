import 'package:dorandoran/common/quest_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/postcard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

//글 가져오기
Future<List<postcard>> getPostContent(
    String? url, int number) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String userEmail=prefs.getString("email")!;
  String location="${prefs.getString("latitude")!},${prefs.getString("longtitude")!}";
  var response = await http.get(
    Uri.parse(
        '${urls}/api/post${url ?? ""}?userEmail=${userEmail}&postCnt=${number}&location=${location}'),
    headers: <String, String>{
      'authorization':'Bearer $accessToken',
    },
  );
print(response.statusCode);
  if (response.body==[]) {
    getPostContent(url, number - 1);
  }
  else if(response.statusCode==401){
    quest_token();
    getPostContent(url, number);
  }

  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  List<postcard> card = body.map((dynamic e) => postcard.fromJson(e)).toList();
  return card;
}
