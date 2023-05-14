import 'package:dorandoran/common/storage.dart';
import 'package:dorandoran/texting/post_datail/component/post_detail_reply_card.dart';
import 'package:dorandoran/texting/post_datail/quest/post_detail_deletecomment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/util.dart';
import '../quest/post_detail_commentlike.dart';
import '../post_detail.dart';

class CommentCard extends StatefulWidget {
  final int commentId;
  final String comment;
  final int commentLike;
  final bool commentLikeResult;
  final List<dynamic>? replies;
  final String commentNickname;
  final String commentTime;
  final VoidCallback changeinputtarget;
  final int postId;
  final String? commentAnonymityNickname;
  final bool commentCheckDelete;
  final VoidCallback deletedreply;

  const CommentCard(
      {required this.commentId,
      required this.comment,
      required this.commentLike,
      required this.commentLikeResult,
      required this.replies,
      required this.commentNickname,
      required this.commentTime,
      required this.postId,
      required this.changeinputtarget,
        required this.commentAnonymityNickname,
        required this.commentCheckDelete,
        required this.deletedreply,
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
      commentlike.addAll({widget.commentId: widget.commentLikeResult});
      commentlikecnt.addAll({widget.commentId: widget.commentLike});
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget replycardd = Container();
    return FutureBuilder(
        future: getreply(widget.replies),
        builder: (context, snapshot) {
          if (snapshot.hasData) replycardd = snapshot.data!;
          {
            return Column(children: [
              Container(
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r)),
                      elevation: 4, //그림자
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(children: [
                            Icon(
                              Icons.person,
                              size: 50.r,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(widget.commentCheckDelete ?"삭제":
                                        ( widget.commentAnonymityNickname ?? widget.commentNickname),
                                          style:
                                              GoogleFonts.jua(fontSize: 17.sp),
                                        ),
                                      ),
                                      widget.commentCheckDelete==false? ("nickname7" == widget.commentNickname
                                          ? TextButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false, // 바깥 영역 터치시 닫을지 여부
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        backgroundColor: Colors.white,
                                                        content: const Text("작성한 댓글을 삭제하시겠습니까?"),
                                                        actions: [
                                                          TextButton(
                                                            child: const Text('확인',
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w700)),
                                                            onPressed: () async {
                                                              await deletecomment(widget.commentId,useremail);
                                                              widget.deletedreply();
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: const Text('취소',
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w700)),
                                                            onPressed: ()  {
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                              style: TextButton.styleFrom(
                                                minimumSize:
                                                    Size.fromRadius(10.r),
                                                padding: EdgeInsets.zero,
                                              ),
                                              child: Text(
                                                "삭제",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            )
                                          : Container() ):Container()
                                    ],
                                  ),
                                  Text(
                                    widget.commentCheckDelete ? "!삭제된 댓글입니다.!": widget.comment,
                                    style: GoogleFonts.jua(),
                                  ),
                                  Row(children: [
                                    Expanded(
                                      child: Text(
                                        timecount(widget.commentTime),
                                        style: TextStyle(fontSize: 12.sp),
                                      ),
                                    ),
                                    Row(
                                      //하트버튼
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if(commentlikecnt[widget.commentId]!=null) { //있던 댓글
                                              setState(() {
                                                commentlike[widget.commentId] =
                                                !commentlike[widget.commentId]!;
                                                if (widget.commentLikeResult ==
                                                    true &&
                                                    commentlike[widget
                                                        .commentId] ==
                                                        false) {
                                                  //눌린상태에서 취소
                                                  commentlikecnt[widget
                                                      .commentId] =
                                                      commentlikecnt[widget
                                                          .commentId]! - 1;
                                                } else
                                                if (widget.commentLikeResult ==
                                                    false &&
                                                    commentlike[widget
                                                        .commentId] == true) {
                                                  //누르기
                                                  commentlikecnt[widget
                                                      .commentId] =
                                                      commentlikecnt[widget
                                                          .commentId]! + 1;
                                                } else {
                                                  //해당화면에서 상태변경취소
                                                  commentlikecnt[widget
                                                      .commentId] =
                                                      widget.commentLike;
                                                }
                                              });
                                            }
                                            else{
                                              setState(() {
                                                commentlike[widget.commentId]=true;
                                                commentlikecnt[widget.commentId]= 1;
                                              });
                                            }
                                            // 댓글좋아요
                                            commentLike(widget.postId,
                                                widget.commentId, useremail);
                                          },
                                          icon: commentlike[widget.commentId]==true
                                              ? Icon(Icons.favorite)
                                              : Icon(Icons.favorite_border),
                                          constraints: BoxConstraints(),
                                          padding: EdgeInsets.zero,
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                            '${commentlikecnt[widget.commentId] ??0}'),
                                        SizedBox(width: 5.w),
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            onPressed: () {
                                              select = widget.commentId;
                                              widget.changeinputtarget();
                                            },
                                            icon: Icon(
                                                Icons.chat_bubble_outline)),
                                        SizedBox(width: 2.w),
                                        Text('${widget.replies!.length}'),
                                      ],
                                    ),
                                  ])
                                ],
                              ),
                            )
                          ])))),
              replycardd
            ]);
          }
        });
  }

  Future<Widget> getreply(dynamic replies) async {
    return replies != null
        ? ListBody(
            children: await replies!
                .map<ReplyCard>((a) => ReplyCard(
                    replyId: a['replyId'],
                    replyNickname: a['replyNickname'],
                    reply: a['reply'],
              replyAnonymityNickname: a['replyAnonymityNickname'],
              replyCheckDelete:a['replyCheckDelete'],
                    replyTime: a['replyTime'],
              deletedreply: widget.deletedreply,
                ))
                .toList())
        : Center();
  }
}