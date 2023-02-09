import 'package:dorandoran/common/css.dart';
import 'package:dorandoran/common/storage.dart';
import 'package:dorandoran/common/util.dart';
import 'package:dorandoran/user/sign_up/screen/using_agree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../../../texting/write/screen/write.dart';
import '../component/mainlogo.dart';

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
    OAuthToken token;
    if (await isKakaoTalkInstalled()) {
      try {
        token = await UserApi.instance.loginWithKakaoTalk();
        kakaotoken = token.accessToken.toString();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UsingAgree()));
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          token = await UserApi.instance.loginWithKakaoAccount();
          kakaotoken = token.accessToken.toString();
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
        print("어3");
        token = await UserApi.instance
            .loginWithKakaoAccount();
        print("미");
        kakaotoken = token.accessToken.toString();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UsingAgree()));
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }
}