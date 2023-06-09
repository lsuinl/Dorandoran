//글써서 보내기
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:dio/dio.dart';

import '../../../common/storage.dart';

//formdata형식
Future<int> writing(
    String email,
    String content,
    bool forme,
    String? locations,
    String? backgroundImgName,
    List<String>? hashTag,
    MultipartFile? file,
    String font,
    String fontColor,
    int fontSize,
    int fontBold,
    bool anaoymity) async {
  var response = await http.post(Uri.parse('${url}/api/post'),
      headers: <String, String>{
        'authorization': 'Bearer $refreshToken',
      },
      body: FormData.fromMap({
        'email': email,
        'content': content,
        'forMe': forme,
        'location': locations,
        'backgroundImgName': backgroundImgName,
        'hashTagName': hashTag,
        'file': file,
        'font': font,
        'fontColor': fontColor,
        'fontSize': fontSize,
        'fontBold': fontBold,
        'anonymity': anaoymity
      }));
  if (response.statusCode == 200) {
    print(200);
    return 200;
  } else {
    print(400);
    return 400;
  }
}
