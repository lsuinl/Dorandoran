import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

questkakaologin() async {
  final prefs = await SharedPreferences.getInstance();
  OAuthToken token;
  if (await isKakaoTalkInstalled()) {
    try {
      token = await UserApi.instance.loginWithKakaoTalk();
      String kakaotoken = token.accessToken.toString();
      prefs.setString('kakaotoken', kakaotoken);
      User user = await UserApi.instance.me();
      if (user.kakaoAccount != null) {
        String kakaoemail = user.kakaoAccount!.email.toString();
        prefs.setString('email', kakaoemail);
        return 200;
      }
    } catch (error) {
      try {
        token = await UserApi.instance.loginWithKakaoAccount();
        String kakaotoken = token.accessToken.toString();
        prefs.setString('kakaotoken', kakaotoken);
        User user = await UserApi.instance.me();
        if (user.kakaoAccount != null) {
          String kakaoemail = user.kakaoAccount!.email.toString();
          prefs.setString('email', kakaoemail);
          return 200;
        }
      }
      catch (error){
        print('카카오계정으로 로그인 실패2 $error');
        return 100;
      }
    }
  } else {
    try {
      token = await UserApi.instance.loginWithKakaoAccount();
      String kakaotoken = token.accessToken.toString();
      prefs.setString('kakaotoken', kakaotoken);
      User user = await UserApi.instance.me();
      if(user.kakaoAccount != null) {
        String kakaoemail = user.kakaoAccount!.email.toString();
        prefs.setString('email', kakaoemail);
        return 200;
      }
    } catch (error) {
      print('카카오계정으로 로그인 실패2 $error');
      return 100;
    }
  }
}
