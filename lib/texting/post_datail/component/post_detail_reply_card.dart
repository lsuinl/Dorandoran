import 'package:dorandoran/texting/home/home.dart';
import 'package:dorandoran/texting/post_datail/model/postcard_detaril.dart';
import 'package:dorandoran/texting/post_datail/quest/reply/delete_postdetail_reply_delete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../../common/util.dart';
import '../post_detail.dart';
import '../quest/post/post_block_member.dart';
import '../quest/post/post_postdetail_post_detail.dart';
import '../quest/report/post_report_reply.dart';

class ReplyCard extends StatefulWidget {
  final int postId;
  final int replyId;
  final String replyNickname;
  final String reply;
  final String? replyAnonymityNickname;
  final bool replyCheckDelete;
  final String replyTime;
  final VoidCallback deletedreply;
  final bool isWrittenByMember;
  final bool isLocked;

  const ReplyCard(
      {required this.postId,
      required this.replyId,
      required this.replyNickname,
      required this.reply,
      required this.replyAnonymityNickname,
      required this.replyCheckDelete,
      required this.replyTime,
      required this.deletedreply,
        required this.isLocked,
      required this.isWrittenByMember,

      Key? key})
      : super(key: key);

  @override
  State<ReplyCard> createState() => _ReplyCardState();
}

class _ReplyCardState extends State<ReplyCard> {
  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
              key: ObjectKey(widget.replyId),
              trailingActions: (widget.replyCheckDelete || widget.isLocked)
                  ? []
                  : widget.isWrittenByMember == true
                      ?
                      //삭제
                      [
                          SwipeAction(
                              icon: Icon(Icons.delete, size: 30.r),
                              onTap: (CompletionHandler handler) async {
                                ondelete();
                                //await handler(true);
                              },
                              color: Theme.of(context).brightness==Brightness.dark?Colors.black26:const Color(0xFFD9D9D9))
                        ]
                      :
                      //신고/차단
                      [
                          SwipeAction(
                              icon: Icon(SolarIconsOutline.sirenRounded,
                                  size: 30.r),
                              onTap: (CompletionHandler handler) async {
                                onsiren();
                                // await handler(true);
                                // setState(() {});
                              },
                              color: Theme.of(context).brightness==Brightness.dark?Colors.black26:const Color(0xFFD9D9D9))
                        ],
              child: Row(children: [
                SizedBox(width: 40.w),
                Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Row(children: [
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.replyCheckDelete
                                ? Text("삭제", style: GoogleFonts.gamjaFlower())
                                : Row(
                                    children: [
                                      Text(
                                        widget.replyAnonymityNickname ??
                                            widget.replyNickname,
                                        style: GoogleFonts.gamjaFlower(
                                            fontSize: 17.sp),
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: Text(
                                            timecount(widget.replyTime),
                                            style: TextStyle(
                                                fontSize: 12.sp)),
                                      ),
                                    ],
                                  ),
                            Text(widget.replyCheckDelete
                                ? "삭제된 댓글입니다"
                                : widget.reply),
                          ],
                        ),
                      )
                    ])))
              ]));
  }

  ondelete() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("작성한 대댓글을 삭제하시겠습니까?", style:  Theme.of(context).textTheme.labelSmall!,),
            actions: [
              TextButton(
                child: Text('확인',
                    style: Theme.of(context).textTheme.labelSmall!),
                onPressed: () async {
                  int isdelete = await DeleteReplyDelete(widget.replyId);
                  if(isdelete==204) {
                    Fluttertoast.showToast(msg: "대댓글이 삭제되었습니다.");
                    postcardDetail e = await PostPostDetail(widget.postId, "");
                    if(e==404){
                      Fluttertoast.showToast(msg: "이미 삭제된 글입니다.");
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    }
                    else
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostDetail(postId: widget.postId, e: e,)))
                        .then((value) => setState(() {}));
                  }
                },
              ),
              TextButton(
                  child: Text('취소',style:Theme.of(context).textTheme.labelSmall!),
                  onPressed: () => Navigator.of(context).pop()),
            ],
          );
        });
  }

  onsiren() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: Text('신고', style: Theme.of(context).textTheme.headlineMedium!),
              onPressed: () {
                showDialog(
                    barrierColor: Colors.white70,
                    context: context,
                    barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                    builder: (BuildContext context) {
                      return AlertDialog(
                          elevation: 0,
                          title: const Center(child: Text("신고항목 선택")),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(color: Colors.black26),
                          ),
                          content: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border:
                              Border.all(width: 2, color: Colors.black12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width, 0),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    onPressed: () {
                                      sendreport('선정성');
                                      Navigator.pop(context);
                                    },
                                    child: Text(" 1.선정성",
                                        style: Theme.of(context).textTheme.bodyLarge!)),
                                Container(height: 2, color: Colors.black12),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            0)),
                                    onPressed: () {
                                      sendreport('폭력성');
                                      Navigator.pop(context);
                                    },
                                    child: Text(" 2.폭력성",
                                        style:Theme.of(context).textTheme.bodyLarge!)),
                                Container(height: 2, color: Colors.black12),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            0)),
                                    onPressed: () {
                                      sendreport('욕설 및 비방');
                                      Navigator.pop(context);
                                    },
                                    child: Text(" 3.욕설 및 비방",
                                        style: Theme.of(context).textTheme.bodyLarge!)),
                                Container(height: 2, color: Colors.black12),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            0)),
                                    onPressed: () {
                                      sendreport('광고');
                                      Navigator.pop(context);
                                    },
                                    child: Text(" 4.광고",
                                        style: Theme.of(context).textTheme.bodyLarge!)),
                                Container(height: 2, color: Colors.black12),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            0)),
                                    onPressed: () {
                                      sendreport('불건전한 만남 유도');
                                      Navigator.pop(context);
                                    },
                                    child: Text(" 5.불건전한 만남 유도",
                                        style:Theme.of(context).textTheme.bodyLarge!)),
                                Container(height: 2, color: Colors.black12),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            0)),
                                    onPressed: () {
                                      sendreport('불건전한 닉네임');
                                      Navigator.pop(context);
                                    },
                                    child: Text(" 6.불건전한 닉네임",
                                        style: Theme.of(context).textTheme.bodyLarge!)),
                                Container(height: 2, color: Colors.black12),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            0)),
                                    onPressed: () {
                                      sendreport('기타');
                                      Navigator.pop(context);
                                    },
                                    child: Text(" 7.기타",
                                        style: Theme.of(context).textTheme.bodyLarge!)),
                              ],
                            ),
                          ));
                    });
              },
            ),
            CupertinoActionSheetAction(
              child:  Text('차단', style: Theme.of(context).textTheme.headlineMedium!),
              onPressed: () {
                setState(() {
                  PostBlockMember("reply", widget.replyId);
                });
                Fluttertoast.showToast(msg: "해당 사용자가 차단되었습니다.");
                Navigator.pop(context);
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
              child: Text('취소', style:Theme.of(context).textTheme.headlineMedium!),
              onPressed: () => Navigator.pop(context))),
    );
  }

  void sendreport(String name) async {
    int num = await PostReportReply(widget.replyId, name);
    if (num == 201) Fluttertoast.showToast(msg: "신고가 접수되었습니다.");
    else{
      Fluttertoast.showToast(msg: "이미 신고가 처리되었습니다.");
    }
  }
}
