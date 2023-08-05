import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

//회원 탈퇴하기
Future<int> DeleteAccountClosure() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response= await http.delete(
    Uri.parse('$urls/api/member'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization':'Bearer $accessToken',
    },
  );
  print(response.statusCode);
  if(response.statusCode==200) {
    print(response.statusCode);
    prefs.remove("nickname");
    prefs.remove("email");
    prefs.remove("accessToken");
    prefs.remove("refreshToken");
  }
  return response.statusCode;
}
