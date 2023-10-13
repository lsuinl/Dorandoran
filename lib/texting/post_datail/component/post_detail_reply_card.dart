import 'package:dorandoran/texting/post_datail/model/postcard_detaril.dart';
import 'package:dorandoran/texting/post_datail/quest/reply/delete_postdetail_reply_delete.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
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
                              color: Color(0xFFD9D9D9))
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
                              color: Color(0xFFD9D9D9))
                        ],
              child: Container(
                  child: Row(children: [
                SizedBox(width: 40.w),
                Expanded(
                    child: Container(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Row(children: [
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.replyCheckDelete
                                        ? Text("삭제", style: GoogleFonts.jua())
                                        : Row(
                                            children: [
                                              Text(
                                                widget.replyAnonymityNickname ??
                                                    widget.replyNickname,
                                                style: GoogleFonts.jua(
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
                                        ? "!삭제된 댓글입니다!"
                                        : widget.reply),
                                  ],
                                ),
                              )
                            ]))))
              ])));
        ;
  }

  ondelete() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: const Text("작성한 대댓글을 삭제하시겠습니까?"),
            actions: [
              TextButton(
                child: const Text('확인',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
                onPressed: () async {
                  await DeleteReplyDelete(widget.replyId);
                  postcardDetail e =  await PostPostDetail(widget.postId,"");
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PostDetail(postId: widget.postId,e: e,)))
                      .then((value) => setState(() {}));
                },
              ),
              TextButton(
                  child: const Text('취소',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
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
              child: const Text('신고', style: TextStyle(color: Colors.black)),
              onPressed: () {
                showDialog(
                    barrierColor: Colors.white70,
                    context: context,
                    barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                    builder: (BuildContext context) {
                      return AlertDialog(
                          elevation: 0,
                          title: Center(child: Text("신고항목 선택")),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(color: Colors.black26),
                          ),
                          content: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
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
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            0)),
                                    onPressed: () => sendreport('선정성'),
                                    child: Text(" 1.선정성",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black87))),
                                Container(height: 2, color: Colors.black12),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            0)),
                                    onPressed: () => sendreport('폭력성'),
                                    child: Text(" 2.폭력성",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black87))),
                                Container(height: 2, color: Colors.black12),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            0)),
                                    onPressed: () => sendreport('욕설 및 비방'),
                                    child: Text(" 3.욕설 및 비방",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black87))),
                                Container(height: 2, color: Colors.black12),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            0)),
                                    onPressed: () => sendreport('광고'),
                                    child: Text(" 4.광고",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black87))),
                                Container(height: 2, color: Colors.black12),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            0)),
                                    onPressed: () => sendreport('불건전한 만남 유도'),
                                    child: Text(" 5.불건전한 만남 유도",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black87))),
                                Container(height: 2, color: Colors.black12),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            0)),
                                    onPressed: () => sendreport('불건전한 닉네임'),
                                    child: Text(" 6.불건전한 닉네임",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black87))),
                                Container(height: 2, color: Colors.black12),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            0)),
                                    onPressed: () => sendreport('기타'),
                                    child: Text(" 7.기타",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black87))),
                              ],
                            ),
                          ));
                    });
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('차단', style: TextStyle(color: Colors.black)),
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
              child: Text('취소', style: TextStyle(color: Colors.black)),
              onPressed: () => Navigator.pop(context))),
    );
  }

  void sendreport(String name) async {
    int num = await PostReportReply(widget.replyId, name);
    if (num == 201) Fluttertoast.showToast(msg: "신고가 접수되었습니다.");
  }
}
