import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/const/storage.dart';


getPostContent() async {
  print('실행');
  var response = await http.get(
    getposturl,
  );
  print("실행됨");
  print(response.headers);
  print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    print("서버 통신양호");
  } else if (response.statusCode == 504) {
    print("서버와의 연결이 불안정 합니다.");
  } else {
    print("올바르지 않습니다.");
    throw Exception('Failed to contect Server.');
  }
}
