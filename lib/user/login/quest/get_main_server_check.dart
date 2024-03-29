import 'package:http/http.dart' as http;
import 'package:dorandoran/common/uri.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int> GetMainServerCheck() async {

  var response = await http.get(
    Uri.parse('$urls/api/notification/condition'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );
  print(response.statusCode);
  return response.statusCode;
}
