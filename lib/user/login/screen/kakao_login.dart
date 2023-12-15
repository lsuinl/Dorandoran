import 'package:dorandoran/common/basic.dart';
import 'package:dorandoran/user/login/quest/kakao_login.dart';
import 'package:dorandoran/user/login/quest/registered.dart';
import 'package:dorandoran/user/sign_up/agree/using_agree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../common/util.dart';
import '../../../texting/home/home.dart';
import '../component/mainlogo.dart';

class KaKaoLogin extends StatefulWidget {
  const KaKaoLogin({Key? key}) : super(key: key);

  @override
  State<KaKaoLogin> createState() => _KaKaoLoginState();
}

class _KaKaoLoginState extends State<KaKaoLogin> {
  @override
  Widget build(BuildContext context) {
    return Basic(
      widgets: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              SizedBox(height: 70.h),
              MainLogo(
                  text: "도란도란",
                  style: Theme.of(context).textTheme.headlineLarge!),
              SizedBox(height: 180.h),
              Center(
                child: TextButton(
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
              ),
            ],
          )),
    );
  }
}
