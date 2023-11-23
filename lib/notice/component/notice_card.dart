import 'package:dorandoran/notice/model/read_notice_model.dart';
import 'package:dorandoran/notice/quest/get_read_notice.dart';
import 'package:dorandoran/texting/post_datail/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../texting/post_datail/model/postcard_detaril.dart';
import '../../texting/post_datail/quest/post/post_postdetail_post_detail.dart';

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

    IconData Icontype=setIcon(notificationType);

    return Container(
        color: isRead == true ? null : Colors.grey[700],
        child:
            Padding(padding: EdgeInsets.symmetric(horizontal: 15),
            child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Icon(Icontype, color: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black, size: 30.r,),
        SizedBox(width: 10.w),
        Expanded(child:
        TextButton(
            onPressed: ()async {
              ReadNoticeModel moveId= await GetReadNotice(notificationId);
              postcardDetail e =  await PostPostDetail(moveId.postId,"");
              Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetail(postId: moveId.postId,e:e)));
            },
            style: TextButton.styleFrom(
              alignment: Alignment.centerLeft,
              primary: Colors.black,
              animationDuration: Duration(seconds: 0),
            ),
            child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headlineMedium!),
                  Text(message, style: Theme.of(context).textTheme.bodyMedium),
                  Text(notificationTime, style: Theme.of(context).textTheme.bodySmall!)
                ])))
          ])
    ));
  }

  IconData setIcon(String notificationType){
    if(notificationType=="PostLike")
      return SolarIconsOutline.heart;
    else if(notificationType=="CommentLike")
      return SolarIconsOutline.heart;
    else if(notificationType=="Comment")
      return SolarIconsOutline.chatLine;
    else
      return SolarIconsOutline.chatLine;
  }
}