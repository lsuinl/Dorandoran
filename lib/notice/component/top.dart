import 'package:dorandoran/notice/quest/patch_read_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../texting/home/home.dart';
import '../quest/del_notice.dart';

class Top extends StatefulWidget {
  final VoidCallback rebuild;

  const Top({
    required this.rebuild,
    super.key});

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: ()=>  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Home()),(route)=>false),
          icon: Icon(SolarIconsOutline.doubleAltArrowLeft,size: 30.r),
        ),
        Text("알림", style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w900)),
        Container(width: 35.w,)
      ],
    ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () async {
                  deleteNotification(false, 0);
                },
                icon: Icon(Icons.check)
            ),
            IconButton(
                onPressed: () {
                  deleteNotification(true, null);
                },
                icon: Icon(Icons.delete)
            )
          ],
        )

    ]
    );
  }
  //전체삭제
  deleteNotification(bool delete, int? datas){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:Theme.of(context).brightness==Brightness.dark?Colors.black26:Colors.white,
            content: Text(
              delete==true ?  "모든 기록을 삭제합니다.": "모든 기록을 읽음처리합니다.",
              style: Theme.of(context).textTheme.bodyMedium!,
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    if(delete==true){
                      await DelNotice(0);
                      Fluttertoast.showToast(msg: '삭제가 완료되었습니다.');
                    }
                    else{
                      await PatchReadNotice(0);
                      Fluttertoast.showToast(msg: '읽음처리가 완료되었습니다.');
                    }
                    Navigator.pop(context);
                    widget.rebuild();
                  },
                  child: Text(
                    "확인",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!,
                  )),
              TextButton(
                  onPressed: () =>
                      Navigator.pop(context),
                  child: Text(
                    "취소",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!,
                  )),
            ],
          );
        });
  }
}