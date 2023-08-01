import 'package:dorandoran/common/basic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/css.dart';

class SettingListScreen extends StatelessWidget {
  const SettingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("설정"),
        ),
        body: Container(
            color: backgroundcolor,
            child: SafeArea(
                top: true,
                bottom: true,
                child: Center(
                    child:Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                fit: FlexFit.tight,
                  child:
              TextButton(
                  onPressed: (){},
                  child: Text("닉네임 변경",style: TextStyle(color: Colors.black),),
                  style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                  )
              )
              ),
              Container(height: 1.h,color: Colors.black26),
            Flexible(
              fit: FlexFit.tight,
              child: TextButton(
                  onPressed: (){},
                  child: Text("내가 쓴 글",style: TextStyle(color: Colors.black),),
                  style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft)
              )),
              Container(height: 1.h,color: Colors.black26),
            Flexible(
              fit: FlexFit.tight,
              child:
              TextButton(
                  onPressed: (){},
                  child: Text("내가 좋아요 한 글",style: TextStyle(color: Colors.black),),
                  style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft)
              )),
              Container(height: 1.h,color: Colors.black26),
            Flexible(
              fit: FlexFit.tight,
              child: TextButton(
                  onPressed: (){},
                  child: Text("설정",style: TextStyle(color: Colors.black),),
                  style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft)
              )),
              Container(height: 1.h,color: Colors.black26),
            Flexible(
              fit: FlexFit.tight,
              child: TextButton(
                  onPressed: (){},
                  child: Text("공지",style: TextStyle(color: Colors.black),),
                  style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft)
              )),
              Container(height: 1.h,color: Colors.black26),
            Flexible(
              fit: FlexFit.tight,
              child: TextButton(
                  onPressed: (){},
                  child: Text("문의하기",style: TextStyle(color: Colors.black),),
                  style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft)
              )),
              Container(height: 1.h,color: Colors.black26),
            Flexible(
              fit: FlexFit.tight,
              child: TextButton(
                  onPressed: (){},
                  child: Text("앱 버전",style: TextStyle(color: Colors.black),),
                  style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft)
              )),
              Container(height: 1.h,color: Colors.black26),
            Flexible(
              fit: FlexFit.tight,
              child: TextButton(
                  onPressed: (){},
                  child: Text("탈퇴하기",style: TextStyle(color: Colors.black),),
                  style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft)
              )),
              Container(height: 1.h,color: Colors.black26),
            ],
          )
        )
    ))));
  }
}
