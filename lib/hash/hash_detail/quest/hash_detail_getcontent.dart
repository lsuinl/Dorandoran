import 'package:dorandoran/common/quest_token.dart';
import 'package:dorandoran/texting/home/model/postcard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:dio/dio.dart';
//글 가져오기
//인코딩
Future<dynamic> getHashContent(
    String tagname, int number) async {

  Dio dio=Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String location="${prefs.getString("latitude")??"123"},${prefs.getString("longtitude")??"123"}";
 var response= await dio.get(
    '${urls}/api/post/hashtag',
    options: Options( headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    }),
    data: jsonEncode({
      "hashtagName":tagname,
      "postCnt": number,
      "location":location
    }),
  );
 print(response.data);
  if (response.data['Data']==[]) {
    getHashContent(tagname, number - 1);
  }
  else if(response.statusCode==401)
    return response.statusCode;

  List<dynamic> body = response.data['Data'];
  //jsonDecode(utf8.decode(response.bodyBytes));
  List<postcard> card = body.map((dynamic e) => postcard.fromJson(e)).toList();
  List<dynamic> result=[response.data['isBookmarked'],card];
  return result;
}
