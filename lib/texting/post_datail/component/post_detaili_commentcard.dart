import 'package:dorandoran/texting/post_datail/component/post_detail_reply_card.dart';
import 'package:dorandoran/texting/post_datail/model/commentcard.dart';
import 'package:dorandoran/texting/post_datail/quest/comment/delete_postdetail_comment_delete.dart';
import 'package:dorandoran/texting/post_datail/quest/reply/get_postdetail_reply_plus.dart';
import 'package:dorandoran/texting/post_datail/quest/report/post_report_comment.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../../common/quest_token.dart';
import '../../../common/util.dart';
import '../model/postcard_detaril.dart';
import '../model/replycard.dart';
import '../quest/reply/delete_postdetail_reply_delete.dart';
import '../quest/post/post_block_member.dart';
import '../quest/comment/post_postdetail_comment_like.dart';
import '../post_detail.dart';
import '../quest/post/post_postdetail_post_detail.dart';

class CommentCard extends StatefulWidget {
  final commentcard card;
  final VoidCallback setstates;
  final VoidCallback changeinputtarget;
  final int postId;

  const CommentCard(
      {required this.card,
      required this.setstates,
      required this.changeinputtarget,
      required this.postId,
      Key? key})
      : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

Map<int, bool> commentlike = {0: false};
Map<int, int> commentlikecnt = {0: 0};

class _CommentCardState extends State<CommentCard> {
  bool isExistNextReply = false;
  List<ReplyCard> replycardd = [];

  @override
  void initState() {
    isExistNextReply = widget.card.replies['isExistNextReply'];
    replycardd = widget.card.replies['replyData']!
        .map<ReplyCard>((a) => ReplyCard(
              replyId: a['replyId'],
              replyNickname: a['replyNickname'],
              reply: a['reply'],
              isLocked: a['isLocked'],
              replyAnonymityNickname: a['replyAnonymityNickname'],
              replyCheckDelete: a['replyCheckDelete'],
              replyTime: a['replyTime'],
              isWrittenByMember: a['isWrittenByMember'],
              postId: widget.postId,
              deletedreply: widget.setstates,
            ))
        .toList();
    super.initState();
    print(widget.card.commentId);
    setState(() {
      commentlike
          .addAll({widget.card.commentId: widget.card.commentLikeResult});
      commentlikecnt.addAll({widget.card.commentId: widget.card.commentLike});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(children: [
                Expanded(
                    child: SwipeActionCell(
                  key: ObjectKey(widget.card.commentId),
                  trailingActions:
                      (widget.card.commentCheckDelete || widget.card.isLocked)
                          ? []
                          : widget.card.isWrittenByMember == true
                              ? [
                                  SwipeAction(
                                      icon: Icon(Icons.delete, size: 30.r),
                                      onTap: (CompletionHandler handler) async {
                                        ondelete();
                                      },
                                      color: Color(0xFFD9D9D9))
                                ]
                              : [
                                  SwipeAction(
                                      icon: Icon(SolarIconsOutline.sirenRounded,
                                          size: 30.r),
                                      onTap: (CompletionHandler handler) async {
                                        onsiren();
                                      },
                                      color: Color(0xFFD9D9D9))
                                ],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.card.commentCheckDelete
                                ? "삭제"
                                : (widget.card.commentAnonymityNickname ??
                                    widget.card.commentNickname),
                            style: GoogleFonts.jua(fontSize: 17.sp),
                          ),
                          SizedBox(width: 3),
                          Expanded(
                              child: Text(
                            timecount(widget.card.commentTime),
                            style: TextStyle(fontSize: 12.sp),
                          )),
                        ],
                      ),
                      Text(widget.card.commentCheckDelete
                          ? "!삭제된 댓글입니다.!"
                          : widget.card.comment),
                      Row(children: [
                        Expanded(
                          child: Text(
                              '좋아요 ${commentlikecnt[widget.card.commentId] ?? 0}'),
                        ),
                        Row(
                          //하트버튼
                          children: [
                            IconButton(
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                if (widget.card.commentNickname ==
                                    prefs.getString("nickname"))
                                  Fluttertoast.showToast(
                                      msg: "자신의 댯글은 좋아요를 누를 수 없습니다.");
                                else {
                                  if (commentlikecnt[widget.card.commentId] !=
                                      null) {
                                    //있던 댓글
                                    setState(() {
                                      commentlike[widget.card.commentId] =
                                          !commentlike[widget.card.commentId]!;
                                      if (widget.card.commentLikeResult ==
                                              true &&
                                          commentlike[widget.card.commentId] ==
                                              false) //눌린상태에서 취소
                                        commentlikecnt[widget.card.commentId] =
                                            commentlikecnt[
                                                    widget.card.commentId]! -
                                                1;
                                      else if (widget.card.commentLikeResult ==
                                              false &&
                                          commentlike[widget.card.commentId] ==
                                              true) //누르기
                                        commentlikecnt[widget.card.commentId] =
                                            commentlikecnt[
                                                    widget.card.commentId]! +
                                                1;
                                      else //해당화면에서 상태변경취소
                                        commentlikecnt[widget.card.commentId] =
                                            widget.card.commentLike;
                                    });
                                  } else {
                                    setState(() {
                                      commentlike[widget.card.commentId] = true;
                                      commentlikecnt[widget.card.commentId] = 1;
                                    });
                                  }
                                  PostCommentLike(widget.postId,
                                      widget.card.commentId); // 댓글좋아요
                                }
                              },
                              icon: commentlike[widget.card.commentId] == true
                                  ? Icon(SolarIconsBold.heart)
                                  : Icon(SolarIconsOutline.heart),
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                            SizedBox(width: 5.w),
                            IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                onPressed: () {
                                  select = widget.card.commentId;
                                  widget.changeinputtarget();
                                },
                                icon: Icon(SolarIconsOutline.dialog)),
                          ],
                        ),
                      ])
                    ],
                  ),
                ))
              ]))),
      isExistNextReply == true
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                  elevation: 2,
                  minimumSize: Size(302.w, 30.h),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  backgroundColor: Color(0xFFBDBDBD),
                  side: BorderSide(
                    color: Color(0xFFFFFFFF),
                    width: 1.0,
                  )),
              onPressed: () async {
                dynamic a = await GetReplyPlus(
                    widget.postId,
                    widget.card.commentId,
                    widget.card.replies['replyData'][0]['replyId']);
                //다음더보기여부
                List<dynamic> cards = a['replyData']
                    .map((dynamic e) => replycard.fromJson(e))
                    .toList();
                setState(() {
                  isExistNextReply = a['isExistNextReply'];
                  replycardd.insertAll(
                      0,
                      cards
                          .map<ReplyCard>((a) => ReplyCard(
                                replyId: a.replyId,
                                replyNickname: a.replyNickname,
                                reply: a.reply,
                                isLocked: a.isLocked,
                                replyAnonymityNickname:
                                    a.replyAnonymityNickname,
                                isWrittenByMember: a.isWrittenByMember,
                                replyCheckDelete: a.replyCheckDelete,
                                replyTime: a.replyTime,
                                postId: widget.postId,
                                deletedreply: widget.setstates,
                              ))
                          .toList());
                  widget.setstates();
                });
              },
              child: Text("대댓글 더보기",
                  style: Theme.of(context).textTheme.headlineMedium!))
          : Container(),
      ListBody(children: replycardd)
    ]);
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
                  await DeleteCommentDelete(widget.card.commentId);
                  postcardDetail e = await PostPostDetail(widget.postId, "");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostDetail(
                                postId: widget.postId,
                                e: e,
                              ))).then((value) => setState(() {}));
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
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width, 0),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    onPressed: () {
                                      sendreport('선정성');
                                      Navigator.pop(context);
                                    },
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
                                    onPressed: () {
                                      sendreport('폭력성');
                                      Navigator.pop(context);
                                    },
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
                                    onPressed: () {
                                      sendreport('욕설 및 비방');
                                      Navigator.pop(context);
                                    },
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
                                    onPressed: () {
                                      sendreport('광고');
                                      Navigator.pop(context);
                                    },
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
                                    onPressed: () {
                                      sendreport('불건전한 만남 유도');
                                      Navigator.pop(context);
                                    },
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
                                    onPressed: () {
                                      sendreport('불건전한 닉네임');
                                      Navigator.pop(context);
                                    },
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
                                    onPressed: () {
                                      sendreport('기타');
                                      Navigator.pop(context);
                                    },
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
                  PostBlockMember("comment", widget.card.commentId);
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

  sendreport(String name) async {
    int num = await PostReportComment(widget.card.commentId, name);
    if (num == 201) Fluttertoast.showToast(msg: "신고가 접수되었습니다.");
  }
}
