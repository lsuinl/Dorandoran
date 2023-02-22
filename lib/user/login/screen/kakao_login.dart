import 'package:dorandoran/common/css.dart';
import 'package:dorandoran/common/storage.dart';
import 'package:dorandoran/common/util.dart';
import 'package:dorandoran/texting/get/screen/home.dart';
import 'package:dorandoran/user/login/quest/logincheck.dart';
import 'package:dorandoran/user/sign_up/quest/namecheck.dart';
import 'package:dorandoran/user/sign_up/screen/using_agree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../../../texting/write/screen/write.dart';
import '../component/mainlogo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KaKaoLogin extends StatefulWidget {
  const KaKaoLogin({Key? key}) : super(key: key);

  @override
  State<KaKaoLogin> createState() => _KaKaoLoginState();
}

class _KaKaoLoginState extends State<KaKaoLogin> {
  @override
  void initState() {
    getlocation();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: gradient,
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  SizedBox(height: 70.h),
                  MainLogo(text: "도란도란", style: whitestyle),
                  SizedBox(height: 180.h),
                  Center(
                      child: TextButton(
                          child: Image.asset(
                            'asset/image/kakao_login.png',
                            alignment: Alignment.center,
                          ),
                          onPressed:questkakaologin,
                          ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  questkakaologin() async {
    final prefs = await SharedPreferences.getInstance();
    OAuthToken token;
    if (await isKakaoTalkInstalled()) {
      try {
        token = await UserApi.instance.loginWithKakaoTalk();
        kakaotoken  =token.accessToken.toString();
        prefs.setString('kakaotoken', kakaotoken!);
        User user = await UserApi.instance.me();
        int ok= await postNameCheckRequest(user.kakaoAccount!.email.toString());
        if(ok==200) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Home()));
        }
        else{
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UsingAgree()));
        }
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          token = await UserApi.instance.loginWithKakaoAccount();
          kakaotoken = token.accessToken.toString();
          prefs.setString('kakaotoken', kakaotoken!);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UsingAgree()));
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {

        token = await UserApi.instance
            .loginWithKakaoAccount();
        kakaotoken = token.accessToken.toString();
        prefs.setString('kakaotoken', kakaotoken!);
        User user = await UserApi.instance.me();
//        print(user.kakaoAccount!.email.toString());
        prefs.setString('email',user.kakaoAccount!.email.toString());
        int ok= await postUserCheckRequest(user.kakaoAccount!.email.toString());
        if(ok==200) {
          print(ok);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Home()));
        }
        else{
          print(ok);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UsingAgree()));
        }
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }
}