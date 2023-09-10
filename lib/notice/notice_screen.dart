import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icons/solar_icons.dart';

import '../common/css.dart';
import '../texting/home/home.dart';
import 'component/top.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: backgroundcolor,
            child: SafeArea(
                top: true,
                bottom: true,
                child: Container(
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Top(),
                              Padding(
                                  padding: EdgeInsets.only(left: 20,top: 20,bottom: 20),
                                  child: Column(children: [
                                    Row(
                                        children:[
                                          TextButton.icon(
                                              onPressed: (){
                                                print("눌림");
                                              },
                                              style: TextButton.styleFrom(
                                                  primary: Colors.white,
                                                  animationDuration: Duration(seconds: 0),
                                                  minimumSize: const Size(330,50),
                                                  alignment: Alignment.centerLeft
                                              ),
                                              icon: Icon(SolarIconsOutline.chatLine,color: Colors.black,),
                                              label: Row(
                                                children: [
                                                  Text("새로운 댓글이 달렸습니다",style: TextStyle(color: Colors.black),),
                                                ],
                                              )
                                          ),
                                          Container(
                                              alignment: Alignment.bottomRight,
                                              child:Text("5분전")
                                          )
                                        ]),
                                    Row(
                                        children:[
                                          TextButton.icon(
                                              onPressed: (){
                                                print("눌림");
                                              },
                                              style: TextButton.styleFrom(
                                                  primary: Colors.white,
                                                  animationDuration: Duration(seconds: 0),
                                                  minimumSize: const Size(330,50),
                                                  alignment: Alignment.centerLeft
                                              ),
                                              icon: Icon(SolarIconsOutline.chatLine,color: Colors.black,),
                                              label: Row(
                                                children: [
                                                  Text("새로운 댓글이 달렸습니다",style: TextStyle(color: Colors.black),),
                                                ],
                                              )
                                          ),
                                          Container(
                                              alignment: Alignment.bottomRight,
                                              child:Text("5분전")
                                          )
                                        ]),
                                    Row(
                                        children:[
                                          TextButton.icon(
                                              onPressed: (){
                                                print("눌림");
                                              },
                                              style: TextButton.styleFrom(
                                                  primary: Colors.white,
                                                  animationDuration: Duration(seconds: 0),
                                                  minimumSize: const Size(330,50),
                                                  alignment: Alignment.centerLeft
                                              ),
                                              icon: Icon(SolarIconsOutline.chatLine,color: Colors.black,),
                                              label: Row(
                                                children: [
                                                  Text("새로운 댓글이 달렸습니다",style: TextStyle(color: Colors.black),),
                                                ],
                                              )
                                          ),
                                          Container(
                                              alignment: Alignment.bottomRight,
                                              child:Text("5분전")
                                          )
                                        ]),
                                  ]))
                            ]))))));
  }
}
