
//글써서 보내기
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';

Future<int> writing(String email,String content, bool forme, String? latitude, String? longtitude, String? backgroundImgName, List<String>? hashTag, File? file) async {
  var response = await http.post(
    posturl,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'email': email,
      'content':content,
      'forMe':forme,
      'location':"122.34,39.93",
      'backgroundImgName':backgroundImgName,
      'hashTagName':hashTag,
      'file':null,
    }),
  );
  print(response.body);
  print('fjkdlsaj');
  if (response.statusCode == 200) {
    return 200;
  } else if (response.statusCode == 500) {
    return 400;
  } else {
    return 0;
  }
}
