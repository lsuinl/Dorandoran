import 'package:dorandoran/common/basic.dart';
import 'package:dorandoran/user/login/quest/kakao_login.dart';
import 'package:dorandoran/user/login/quest/registered.dart';
import 'package:dorandoran/user/sign_up/agree/using_agree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import '../../../common/util.dart';
import '../../../texting/home/home.dart';
import '../component/mainlogo.dart';
import '../quest/apple_login.dart';

class KaKaoLogin extends StatefulWidget {
  const KaKaoLogin({Key? key}) : super(key: key);

  @override
  State<KaKaoLogin> createState() => _KaKaoLoginState();
}

class _KaKaoLoginState extends State<KaKaoLogin> {
  @override
  void initState() {
    permissionquest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Basic(
      widgets: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainLogo(
                  text: "도란",
                  style: Theme.of(context).textTheme.headlineLarge!),
              Column(
                children: [
                TextButton(
                    child: Image.asset(
                      'asset/image/kakao_login.png',
                      alignment: Alignment.center,
                    ),
                    onPressed: () async {
                      if (await questkakaologin() == 200) { //카카오 로그인 체크
                        if (await registered() == 200) //가입된 회원
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => new Home()));
                        else
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UsingAgree()));
                      }
                    }),
                  TextButton(
                      child: Image.asset(
                        Theme.of(context).brightness == Brightness.dark
                            ? 'asset/apple/apple_logo_white.png':'asset/apple/apple_logo_black.png',
                        alignment: Alignment.center,
                      ),
                      onPressed: () async {
                        if (await questAppleLogin() == 200) { //애플 로그인 체크
                          if (await registered() == 200) //가입된 회원
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => new Home()));
                          else
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UsingAgree()));
                        }
                      }),
      ]
              ),
            ],
          )),
    );
  }
}
