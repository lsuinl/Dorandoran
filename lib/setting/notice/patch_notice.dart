import 'package:dorandoran/common/uri.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/quest_token.dart';

//알림 on,off 변경하기
Future<int> PatchNotice() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("accessToken")!;
  http.Response response = await http.patch(
    Uri.parse('$urls/api/notificationStatus'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization': 'Bearer $accessToken',
    },
  );
  if (response.statusCode == 401) {
    int number = await quest_token();
    if (number == 200)
      return PatchNotice();
  }
  return response.statusCode;
}