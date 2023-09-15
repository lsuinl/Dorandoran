import 'package:dorandoran/texting/post_datail/component/post_detail_reply_card.dart';
import 'package:dorandoran/texting/post_datail/model/commentcard.dart';
import 'package:dorandoran/texting/post_datail/quest/delete_postdetail_comment_delete.dart';
import 'package:dorandoran/texting/post_datail/quest/get_postdetail_reply_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../../common/quest_token.dart';
import '../../../common/util.dart';
import '../quest/delete_postdetail_reply_delete.dart';
import '../quest/post_block_member.dart';
import '../quest/post_postdetail_comment_like.dart';
import '../post_detail.dart';
import '../quest/post_postdetail_post_detail.dart';

class CommentCard extends StatefulWidget {
  final commentcard card;
  final VoidCallback deletedreply;
  final VoidCallback changeinputtarget;
  final int postId;

  const CommentCard(
      {required this.card,
      required this.deletedreply,
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
  @override
  void initState() {
    super.initState();
    setState(() {
      commentlike.addAll({widget.card.commentId: widget.card.commentLikeResult});
      commentlikecnt.addAll({widget.card.commentId: widget.card.commentLike});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ReplyCard> replycardd = [];
    return FutureBuilder(
        future: getreply(widget.card.replies['replyData']),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            replycardd = replycardd.length < 10 ? snapshot.data! : replycardd;
            return FutureBuilder(
                future: getnickname(),
                builder: (context, snapshot) {
                  return Column(children: [
                    Container(
                            child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(children: [
                                  Expanded(
                                    child: SwipeActionCell(
                  key: ObjectKey(widget.card.commentId),
                  trailingActions:widget.card.commentCheckDelete?[]:widget.card.isWrittenByMember == true?
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
                  child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                            Text(widget.card.commentCheckDelete ? "삭제" :
                                            (widget.card.commentAnonymityNickname ?? widget.card.commentNickname),
                                              style: GoogleFonts.jua(fontSize: 17.sp),),
                                            SizedBox(width: 3),
                                            Expanded(
                                                child: Text(
                                              timecount(widget.card.commentTime),
                                              style: TextStyle(fontSize: 12.sp),
                                            )),
                                          ],
                                        ),
                                        Text(widget.card.commentCheckDelete ? "!삭제된 댓글입니다.!" : widget.card.comment),
                                        Row(children: [
                                          Expanded(child: Text('좋아요 ${commentlikecnt[widget.card.commentId] ?? 0}'),),
                                          Row(
                                            //하트버튼
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  if (commentlikecnt[widget.card.commentId] != null) {
                                                    //있던 댓글
                                                    setState(() {
                                                      commentlike[widget.card.commentId] = !commentlike[widget.card.commentId]!;
                                                      if (widget.card.commentLikeResult == true && commentlike[widget.card.commentId] == false) //눌린상태에서 취소
                                                        commentlikecnt[widget.card.commentId] = commentlikecnt[widget.card.commentId]! - 1;
                                                       else if (widget.card.commentLikeResult == false && commentlike[widget.card.commentId] == true) //누르기
                                                        commentlikecnt[widget.card.commentId] = commentlikecnt[widget.card.commentId]! + 1;
                                                       else //해당화면에서 상태변경취소
                                                        commentlikecnt[widget.card.commentId] = widget.card.commentLike;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      commentlike[widget.card.commentId] = true;
                                                      commentlikecnt[widget.card.commentId] = 1;
                                                    });
                                                  }
                                                  PostCommentLike(widget.postId, widget.card.commentId);// 댓글좋아요
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
                                  )
                                  )]))),
                    widget.card.replies['isExistNextReply'] == true
                        ? OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                elevation: 2,
                                minimumSize: Size(302.w, 30.h),
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                backgroundColor: Color(0xFFBDBDBD),
                                side: BorderSide(color: Color(0xFFFFFFFF), width: 1.0,)),
                            onPressed: () async {
                              dynamic cards = await GetReplyPlus(
                                  widget.postId,
                                  widget.card.commentId,
                                  widget.card.replies[0]['replyId']);
                              if (cards == 401) {
                                quest_token();
                                Fluttertoast.showToast(msg: "실행 중 오류가 발생했습니다. 다시 시도해 주세요./");
                                PostPostDetail(widget.postId, "");
                              }
                              setState(() {
                                replycardd.insertAll(0, cards.map<ReplyCard>((a) => ReplyCard(
                                              replyId: a.replyId,
                                              replyNickname: a.replyNickname,
                                              reply: a.reply,
                                              replyAnonymityNickname: a.replyAnonymityNickname,
                                              isWrittenByMember: a.isWrittenByMember,
                                              replyCheckDelete: a.replyCheckDelete,
                                              replyTime: a.replyTime,
                                              postId: widget.postId,
                                              deletedreply: widget.deletedreply,
                                            )).toList());
                              });
                            },
                            child: Text("대댓글 더보기", style: Theme.of(context).textTheme.headlineMedium!))
                        : Container(),
                    ListBody(children: replycardd)
                  ]);
                });
        });
  }

  Future<List<ReplyCard>> getreply(dynamic replies) async {
    return replies != null
        ? await replies!
            .map<ReplyCard>((a) => ReplyCard(
                  replyId: a['replyId'],
                  replyNickname: a['replyNickname'],
                  reply: a['reply'],
                  replyAnonymityNickname: a['replyAnonymityNickname'],
                  replyCheckDelete: a['replyCheckDelete'],
                  replyTime: a['replyTime'],
                  isWrittenByMember: a['isWrittenByMember'],
                  postId: widget.postId,
                  deletedreply: widget.deletedreply,
                ))
            .toList()
        : [];
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
                  await DeleteCommentDelete(widget.card.commentId);
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
                  PostBlockMember("comment", widget.card.commentId);
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
