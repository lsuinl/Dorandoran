import 'package:dorandoran/common/quest_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';


//배경사진 개수 알아오기
Future<int> GetPicCount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  var response = await http.get(
    Uri.parse('${urls}/api/pic/default/count'),
    headers: <String, String>{
      'authorization':'Bearer $accessToken',
    },
  );
  if(response.statusCode==401){
    quest_token();
    GetPicCount();
  }
  return int.parse(response.body);
}
