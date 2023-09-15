import 'package:dorandoran/common/quest_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/postcard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

//글 가져오기
Future<dynamic> getPostContent(
    String? url, int number) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String location="${prefs.getString("latitude")??"123"},${prefs.getString("longtitude")??"123"}";
  var response = await http.get(
    Uri.parse(
        '${urls}/api/post${url ?? ""}postCnt=${number}&location=${location}'),
    headers: <String, String>{
      'authorization':'Bearer $accessToken',
    },
  );
print(response.statusCode);
print(response.body);
  if (response.body==[]) {
    return getPostContent(url, number - 1);
  }
  else if(response.statusCode==401){
    int number = await quest_token();
    if(number==200)
      return getPostContent(url, number - 1);
  }
  else if(response.statusCode==204){
    return [];
  }
  else {
    List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
    List<postcard> card = body.map((dynamic e) => postcard.fromJson(e))
        .toList();
    return card;
  }
}
