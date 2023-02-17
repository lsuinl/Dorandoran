
//글써서 보내기
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';

//formdata형식
Future<int> writing(String email,String content, bool forme, String? locations, String? backgroundImgName, List<String>? hashTag, http.MultipartFile? file) async {
  var response = await http.post(
    posturl,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'email': email,
      'content':content,
      'forMe':forme,
      'location':locations,
      'backgroundImgName':backgroundImgName,
      'hashTagName':hashTag,
      'file':file,
    }),
  );
  print('fjkdlsaj');
  if (response.statusCode == 200) {
    print(200);
    return 200;
  } else {
    print(400);
    return 400;
  }
}
