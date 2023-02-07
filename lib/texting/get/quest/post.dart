import 'dart:io';
import '../model/postcard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';

//글 가져오기
Future<List<postcard>> getPostContent(String? userEmail, int number, String location) async {
  var response = await http.get(
    Uri.parse('${getposturl}userEmail=${userEmail}&postCnt=${number}&location=${location}'),
  );
  if (response.statusCode == 201 || response.statusCode == 200) {
    print("실행된넘버:$number");
  } else {
    getPostContent(userEmail, number-1, location);
  }
  List<dynamic> body = json.decode(response.body);
  List<postcard> card =
      body.map((dynamic item) => postcard.fromJson(item)).toList();
  return card;
}
