import 'package:dorandoran/notice/model/read_notice_model.dart';
import 'package:dorandoran/notice/notice_screen.dart';
import 'package:dorandoran/notice/quest/get_read_notice.dart';
import 'package:dorandoran/notice/quest/patch_read_notification.dart';
import 'package:dorandoran/texting/post_datail/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../texting/post_datail/model/postcard_detaril.dart';
import '../../texting/post_datail/quest/post/post_postdetail_post_detail.dart';
import '../quest/del_notice.dart';

class NoticeCard extends StatefulWidget {
  final String notificationType;
  final String notificationTime;
  final String message;
  final String title;
  final bool isRead;
  final int notificationId;

  const NoticeCard({
    required this.notificationId,
    required this.title,
    required this.message,
    required this.isRead,
    required this.notificationTime,
    required this.notificationType,
    super.key});

  @override
  State<NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    IconData Icontype=setIcon(widget.notificationType);
    return Container(
        color: isRead[widget.notificationId] != true ? null : widget.isRead==true? null: Colors.grey[700] ,
        child:
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Icon(Icontype, color: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black, size: 30.r,),
        SizedBox(width: 10.w),
        Expanded(child:
        TextButton(
            onPressed: () async {
              ReadNoticeModel moveId= await GetReadNotice(widget.notificationId);
              dynamic e =  await PostPostDetail(moveId.postId,"");
              setState(() {
                isRead[widget.notificationId]=true;
              });
              if(e==404){
                Fluttertoast.showToast(msg: "이미 삭제된 글입니다.");
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => NoticeScreen()));
              }
              else
              Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetail(postId: moveId.postId,e:e)));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black, alignment: Alignment.centerLeft,
              animationDuration: const Duration(seconds: 0),
            ),
            child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: Theme.of(context).textTheme.headlineMedium!),
                  Text(widget.message, style: Theme.of(context).textTheme.bodyMedium),
                  Text(widget.notificationTime, style: Theme.of(context).textTheme.bodySmall!)
                ])))
          ])
    ));
  }

  IconData setIcon(String notificationType){
    if(notificationType=="PostLike") {
      return SolarIconsOutline.heart;
    } else if(notificationType=="CommentLike")
      return SolarIconsOutline.heart;
    else if(notificationType=="Comment")
      return SolarIconsOutline.chatLine;
    else
      return SolarIconsOutline.chatLine;
  }
}