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

class Login_check extends StatefulWidget {
  const Login_check({Key? key}) : super(key: key);

  @override
  State<Login_check> createState() => _Login_checkState();
}

class _Login_checkState extends State<Login_check> {
@override
void initState() {
    LodingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: gradient,
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child:
              Center(
                  child:
                  Column(
                    children: [
                      SizedBox(height: 70.h),
                      MainLogo(text: "도란도란", style: whitestyle),
                      SizedBox(height: 160.h),
                      SizedBox(height: 20.h,),
                      CircularProgressIndicator(),
                      SizedBox(height: 20.h,),
                      Text("데이터를 로딩 중입니다. 잠시만 기다려주세요.", style: TextStyle(fontSize: 12.sp,color: Colors.white54)),
                    ],
                  )),)
        ),
      ),
    );
  }
  LodingData(){

}
}