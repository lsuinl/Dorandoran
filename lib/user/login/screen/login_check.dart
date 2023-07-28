import 'package:dorandoran/common/basic.dart';
import 'package:dorandoran/common/util.dart';
import 'package:dorandoran/user/login/screen/kakao_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../texting/home/home.dart';
import '../component/mainlogo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_check extends StatefulWidget {
  const Login_check({Key? key}) : super(key: key);

  @override
  State<Login_check> createState() => _Login_checkState();
}

class _Login_checkState extends State<Login_check> {
  @override
  void initState() {
    permissionquest();
    if(Permission.locationWhenInUse.isPermanentlyDenied==false && Permission.locationWhenInUse.isDenied==false) getlocation();
  }

  @override
  Widget build(BuildContext context) {
    logincheck();
    return Basic(widgets: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child:
              Center(
                  child:
                  Column(
                    children: [
                      SizedBox(height: 70.h),
                      MainLogo(text: "도란도란", style:  Theme.of(context).textTheme.headlineLarge!),
                      SizedBox(height: 180.h),
                      CircularProgressIndicator(color: Color(0xFF79AAFF)),
                      SizedBox(height: 20.h,),
                      Text("데이터를 로딩 중입니다. 잠시만 기다려주세요.", style: Theme.of(context).textTheme.bodySmall),
                    ],
                  )),)
        );
  }

  logincheck() async {
    final prefs = await SharedPreferences.getInstance();
    //이미 저장된 이메일이 있는 경우==앱에 로그인 데이터가 남아있는 경우
    if(prefs.getString('accessToken')!=""&&prefs.getString('accessToken')!=null) {
      // prefs.setString('refreshToken', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJqdzEwMTAxMTBAZ21haWwuY29tIiwiaWF0IjoxNjg5MDA0NTU2LCJleHAiOjE3MDQ1NTY1NTYsInN1YiI6IjEyMyIsImVtYWlsIjoiOTY0M3VzQG5hdmVyLmNvbSJ9.y83FD5n38b3AgLhs8RKJBhc2WFFJsI0mOO5UoJOKhiI');
      // prefs.setString('accessToken', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJqdzEwMTAxMTBAZ21haWwuY29tIiwiaWF0IjoxNjg5MDA0NTU2LCJleHAiOjE2ODkwOTA5NTYsInN1YiI6IjEyMyIsImVtYWlsIjoiOTY0M3VzQG5hdmVyLmNvbSJ9.5zFLL4cLju5kTbPJOKA4M_8JkOnaMEemxiIeqprRhLU');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
          new Home()));
    }
    else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
          new KaKaoLogin()));
    }
  }
}
