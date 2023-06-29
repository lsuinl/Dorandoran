import 'package:dorandoran/common/uri.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

//formdata형식
Future<int> writing(String email,String content, bool forme, String? locations, String? backgroundImgName, List<String>? hashTag, MultipartFile? file, String font, String fontColor, int fontSize, int fontBold, bool anaoymity) async {
  var dio=Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  var response = await dio.post(
      '${urls}/api/post',
      options: Options(headers: { 'authorization':'Bearer $accessToken',}),
      data: FormData.fromMap({
        'email': email,
        'content':content,
        'forMe':forme,
        'location':locations,
        'backgroundImgName':backgroundImgName,
        'hashTagName':hashTag,
        'file':file,
        'font':font,
        'fontColor':fontColor,
        'fontSize':fontSize,
        'fontBold':fontBold,
        'anonymity':anaoymity
      })
  );
  if (response.statusCode == 200) {
    print(200);
    return 200;
  } else {
    print(400);
    return 400;
  }
}