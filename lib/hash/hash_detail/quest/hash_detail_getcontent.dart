import 'package:dorandoran/common/quest_token.dart';
import 'package:dorandoran/texting/home/model/postcard.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    '$urls/api/post/hashtag',
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
  if (response.data['Data']==[]) {
    return [];
  }
  if(response.statusCode==401){
    int number=await quest_token();
    if(number==200) {
      return getHashContent(tagname, number);
    }
  }
  List<dynamic> body = response.data['Data'];
  //jsonDecode(utf8.decode(response.bodyBytes));
  List<postcard> card = body.map((dynamic e) => postcard.fromJson(e)).toList();
  List<dynamic> result=[response.data['isBookmarked'],card];
  return result;
}
