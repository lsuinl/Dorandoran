
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:solar_icons/solar_icons.dart';

class NoticeCard extends StatelessWidget {
  final String notificationType;
  final bool isRead;
  final String notificationTime;
  final String message;
  final String title;
  final int notificationId;

    const NoticeCard({
      required this.notificationId,
      required this.title,
      required this.message,
      required this.notificationTime,
      required this.isRead,
      required this.notificationType,
      super.key});

  @override
  Widget build(BuildContext context) {
    return     Row(
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
        ]);
  }
}
