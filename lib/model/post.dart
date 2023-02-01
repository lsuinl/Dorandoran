import 'dart:io';
import 'postcard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/const/storage.dart';

//글 가져오기
Future<List<postcard>> getPostContent() async {
  print('실행');
  var response = await http.get(
    getposturl,
  );
  print("실행됨");
  print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    print("서버 통신양호");
  } else if (response.statusCode == 504) {
    print("서버와의 연결이 불안정 합니다.");
  } else {
    print("올바르지 않습니다.");
    throw Exception('Failed to contect Server.');
  }
  List<dynamic> body = json.decode(response.body);
  List<postcard> card =
      body.map((dynamic item) => postcard.fromJson(item)).toList();
  return card;
}


//글써서 보내기
Future<int> writing(String email,String content, bool forme, String? latitude, String? longtitude, String? backgroundImgName, List<String>? hashTag, File? file) async {
  var response = await http.post(
    namecheckurl,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'email': email,
      'content':content,
      'forMe':forme,
      'location':"${latitude},${longtitude}",
      'backgroundImgName':backgroundImgName,
      'hashTagName':hashTag,
      'file':file,
    }),
  );
  if (response.statusCode == 200) {
    return 200;
  } else if (response.statusCode == 500) {
    return 400;
  } else {
    return 0;
  }
}
