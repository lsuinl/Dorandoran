import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/quest_token.dart';

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
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  var response = await http.post(Uri.parse('${url}/api/post'),
      headers: <String, String>{
        'authorization': 'Bearer $accessToken',
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
  } else if(response.statusCode==401) {
    quest_token();
    writing(
        email,
        content,
        forme,
        locations,
        backgroundImgName,
        hashTag,
        file,
        font,
        fontColor,
        fontSize,
        fontBold,
        anaoymity);
    return 401;
  } else{
    return 400;
  }
  }
