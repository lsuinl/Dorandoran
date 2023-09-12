import 'package:dorandoran/texting/post_datail/quest/delete_postdetail_reply_delete.dart';
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
import '../quest/post_block_member.dart';

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

  const ReplyCard(
      {required this.postId,
      required this.replyId,
      required this.replyNickname,
      required this.reply,
      required this.replyAnonymityNickname,
      required this.replyCheckDelete,
      required this.replyTime,
      required this.deletedreply,
      required this.isWrittenByMember,
      Key? key})
      : super(key: key);

  @override
  State<ReplyCard> createState() => _ReplyCardState();
}

class _ReplyCardState extends State<ReplyCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getnickname(),
        builder: (context, snapshot) {
          return SwipeActionCell(
              key: ObjectKey(widget.replyId),
          trailingActions:widget.replyCheckDelete?[]:widget.isWrittenByMember == true?
          //삭제
          [SwipeAction( icon:Icon(Icons.delete,size: 30.r),
              onTap: (CompletionHandler handler) async {
                ondelete();
                //await handler(true);
              },
              color: Color(0xFFD9D9D9))]:
          //신고/차단
          [SwipeAction( icon:Icon(SolarIconsOutline.sirenRounded,size: 30.r),
                    onTap: (CompletionHandler handler) async {
                      onsiren();
                      // await handler(true);
                      // setState(() {});
                    },
                    color: Color(0xFFD9D9D9))],
          child:Container(
              child: Row(children: [
            SizedBox(width: 10.w),
            Icon(Icons.subdirectory_arrow_right_outlined, size: 30),
            Expanded(
                child: Container(
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                                            widget.replyAnonymityNickname ?? widget.replyNickname,
                                            style: GoogleFonts.jua(fontSize: 17.sp),
                                          ),
                                          SizedBox(width: 5.w),
                                          Expanded(
                                            child: Text(
                                                timecount(widget.replyTime),
                                                style: TextStyle(fontSize: 12.sp)),
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
        });
  }

  ondelete(){
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PostDetail(postId: widget.postId)))
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
            child: const Text('신고',style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('차단',style: TextStyle(color: Colors.black)),
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
            child: Text('취소',style: TextStyle(color: Colors.black)),
            onPressed: ()=>Navigator.pop(context))
      ),
    );
  }
}
