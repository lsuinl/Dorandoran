import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//사용가능닉네임 statusCode:200, 불가능닉네임 statusCode:400
Future<int> postNameCheckRequest(
    // not-null해야됨 / 글자초과x(8자) / 이미 요청하고 안된다고 요청받은 닉네임은 따로 저장해서 막음 / 특수문자제한 / 이모티콘사용불가처리.
    String nickName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  var response = await http.post(
    Uri.parse('$url/api/check-nickname'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "nickname": nickName,
    }),
  );
    return response.statusCode;
}
