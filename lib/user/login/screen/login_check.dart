import 'package:dorandoran/common/basic.dart';
import 'package:dorandoran/common/util.dart';
import 'package:dorandoran/user/login/quest/get_critical_notification.dart';
import 'package:dorandoran/user/login/screen/kakao_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../common/quest_token.dart';
import '../../../texting/home/home.dart';
import '../../../common/model/notification_model.dart';
import '../component/mainlogo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../quest/get_main_server_check.dart';

class Login_check extends StatefulWidget {
  const Login_check({Key? key}) : super(key: key);

  @override
  State<Login_check> createState() => _Login_checkState();
}

class _Login_checkState extends State<Login_check> {
  @override
  void initState() {
    if (Permission.locationWhenInUse.isPermanentlyDenied == false &&
        Permission.locationWhenInUse.isDenied == false) getlocation();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      //위젯을 바로실행시키기 위해 이 함수가 필요하다.
      logincheck();
    });
    return Basic(
        widgets: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Center(
          child: Column(
        children: [
          SizedBox(height: 70.h),
          MainLogo(
              text: "도란도란", style: Theme.of(context).textTheme.headlineLarge!),
          SizedBox(height: 180.h),
          CircularProgressIndicator(color: Color(0xFF79AAFF)),
          SizedBox(
            height: 20.h,
          ),
          Text("데이터를 로딩 중입니다. 잠시만 기다려주세요.",
              style: Theme.of(context).textTheme.bodySmall),
        ],
      )),
    ));
  }

  logincheck() async {
    //서버체크
    int maincheck = await GetMainServerCheck();
    if(maincheck==200){
      final prefs = await SharedPreferences.getInstance();
      //앱에 로그인 데이터가 남아있는 경우
      if (prefs.getString('accessToken') != "" &&
          prefs.getString('accessToken') != null) {
        int tokencheck = await quest_token();
        if (tokencheck == 204 || tokencheck == 200) {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => KaKaoLogin()));
        }
      } else {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => KaKaoLogin()));
      }
    }
    else{
      //부가서버 체크
      dynamic check = await GetCriticalNotification();
      if(check is int){ //부가도 터지면
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  backgroundColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black26
                      : Colors.white,
                  title: Text('긴급 점검 공지'),
                  content: Text('긴급 점검 중입니다. 이용에 불편을 드려 죄송합니다.',
                      style: Theme.of(context).textTheme.headlineMedium!),
                  actions: [
                    TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: Text("확인", style: Theme.of(context).textTheme.labelSmall!,),
                    ),
                  ]);
            });
      }
      else{
        NotificationModel noticemodel = check;
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  backgroundColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black26
                      : Colors.white,
                  title: Text(noticemodel!.title),
                  content: Text(noticemodel!.content,
                      style: Theme.of(context).textTheme.headlineMedium!),
                  actions: [
                    TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: Text("확인", style: Theme.of(context).textTheme.labelSmall!,),
                    ),
                  ]);
            });
      }
    }
  }
}
