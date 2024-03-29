import 'package:dorandoran/common/uri.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/quest_token.dart';

//formdata형식
Future<int> postwritepost(String content,
    bool forme,
    bool usinglocation,
    String? backgroundImgName,
    List<String>? hashTag,
    MultipartFile? file,
    String font,
    String fontColor,
    int fontSize,
    int fontBold,
    bool anaoymity) async {

  var dio = Dio();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  String email = prefs.getString("email")!;
  String location="";
  if(usinglocation==true) {
    location = "${prefs.getString("latitude") ?? ""},${prefs.getString("longtitude") ?? ""}";
  }

  FormData formData =file==null? FormData.fromMap({
    'email': email,
    'content': content,
    'forMe': forme,
    'location': location,
    'hashTagName': hashTag,
    "backgroundImgName": backgroundImgName,
    'font': font,
    'fontColor': fontColor,
    'fontSize': fontSize,
    'fontBold': fontBold,
    'anonymity': anaoymity
  }): FormData.fromMap({
  'email': email,
  'content': content,
  'forMe': forme,
  'location': location,
  'hashTagName': hashTag,
  'file': file,
    "backgroundImgName": null,
  'font': font,
  'fontColor': fontColor,
  'fontSize': fontSize,
  'fontBold': fontBold,
  'anonymity': anaoymity
  });

  var response = await dio.post('$urls/api/post',
      options: Options(headers: {
        'authorization': 'Bearer $accessToken',
      }),
      data: formData
  );
  if(response.statusCode==401) {
    int number = await quest_token();
    if (number == 200) {
      return postwritepost(
          content,
          forme,
          usinglocation,
          backgroundImgName,
          hashTag,
          file,
          font,
          fontColor,
          fontSize,
          fontBold,
          anaoymity);
    }
  }
  return response.statusCode!;
}
