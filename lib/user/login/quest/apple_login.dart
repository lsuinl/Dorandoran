import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

questAppleLogin() async {
  try {
    final credential = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
    ]);

    if (credential == null) {
      // Apple 로그인이 실패한 경우
      return 100;
    }

    List<String> jwt = credential.identityToken?.split('.') ?? [];
    String payload = jwt[1];
    payload = base64.normalize(payload);

    final List<int> jsonData = base64.decode(payload);
    final userInfo = jsonDecode(utf8.decode(jsonData));

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', userInfo['email']);

    // 성공적으로 로그인한 경우
    return 200;
  } catch (e) {
    // 예외가 발생한 경우
    print('로그인 실패: $e');
    return 100;
  }
}
