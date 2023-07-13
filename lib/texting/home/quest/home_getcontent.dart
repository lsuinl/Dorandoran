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
  String location="${prefs.getString("latitude")??"123"},${prefs.getString("longtitude")??"123"}";
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
    return [postcard(postId: 0, contents: "데이터를 불러오지 못했는데요", postTime: "2023-07-08T23:16:48.740877", location: null, likeCnt: 0, likeResult: false, backgroundPicUri: "124.60.219.83:8080/api/background/20", replyCnt: 0, font: "Nanum Gothic", fontColor: "1", fontSize: 20, fontBold: 800)];
  }

  List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
  List<postcard> card = body.map((dynamic e) => postcard.fromJson(e)).toList();
  return card;
}
