import 'package:dorandoran/texting/post_datail/component/post_detail_reply_card.dart';
import 'package:dorandoran/texting/post_datail/model/commentcard.dart';
import 'package:dorandoran/texting/post_datail/model/replycard.dart';
import 'package:dorandoran/texting/post_datail/quest/post_postdetail_comment_delete.dart';
import 'package:dorandoran/texting/post_datail/quest/get_postdetail_reply_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/util.dart';
import '../quest/post_postdetail_comment_like.dart';
import '../post_detail.dart';

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
      commentlike
          .addAll({widget.card.commentId: widget.card.commentLikeResult});
      commentlikecnt.addAll({widget.card.commentId: widget.card.commentLike});
    });
  }

  @override
  Widget build(BuildContext context) {

    List<String> _menulist = ['신고하기','차단하기'];
    if(widget.card.isWrittenByMember==true) _menulist = ['삭제하기'];
    List<ReplyCard> replycardd = [];
    return FutureBuilder(
        future: getreply(widget.card.replies),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            replycardd = replycardd.length < 10 ? snapshot.data! : replycardd;
          {
            return FutureBuilder(
                future: getnickname(),
                builder:(context,snapshot){
              return Column(children: [
              Container(
                  child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                      elevation: 4, //그림자
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(children: [
                            Icon(Icons.person, size: 50.r),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.card.commentCheckDelete
                                              ? "삭제"
                                              : (widget.card.commentAnonymityNickname ??
                                                  widget.card.commentNickname),
                                          style: GoogleFonts.jua(fontSize: 17.sp),
                                        ),
                                      ),
                                      widget.card.commentCheckDelete == false
                                          ?  DropdownButton2(
                                        customButton: Icon(Icons.more_vert),
                                        dropdownWidth: 150,
                                        dropdownDecoration: BoxDecoration(color: Colors.white),
                                        dropdownDirection: DropdownDirection.left,
                                        items: [
                                          ..._menulist.map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          ),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          if(value=="삭제하기"){
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                // 바깥 영역 터치시 닫을지 여부
                                                builder: (BuildContextcontext) {
                                                  return AlertDialog(
                                                    backgroundColor: Colors.white,
                                                    content: const Text("작성한 댓글을 삭제하시겠습니까?"),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text('확인', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
                                                        onPressed: () async {
                                                          await PostCommentDelete(widget.card.commentId);
                                                          Navigator.push(context, MaterialPageRoute(
                                                              builder: (context) => PostDetail(postId: widget.postId))).then((value) => setState(() {}));
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text('취소', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
                                                        onPressed: () =>Navigator.of(context).pop()
                                                      ),
                                                    ],
                                                  );});
                                          }
                                        },
                                      )
                                          : Container()
                                    ],
                                  ),
                                  Text(
                                    widget.card.commentCheckDelete
                                        ? "!삭제된 댓글입니다.!"
                                        : widget.card.comment,
                                    style: GoogleFonts.jua(),
                                  ),
                                  Row(children: [
                                    Expanded(
                                      child: Text(
                                        timecount(widget.card.commentTime),
                                        style: TextStyle(fontSize: 12.sp),
                                      ),
                                    ),
                                    Row(
                                      //하트버튼
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (commentlikecnt[widget.card.commentId] != null) {
                                              //있던 댓글
                                              setState(() {
                                                commentlike[widget.card.commentId] =
                                                    !commentlike[widget.card.commentId]!;
                                                if (widget.card.commentLikeResult == true &&
                                                    commentlike[widget.card.commentId] ==
                                                        false) {
                                                  //눌린상태에서 취소
                                                  commentlikecnt[widget.card.commentId] =
                                                      commentlikecnt[widget.card.commentId]! - 1;
                                                } else if (widget.card.commentLikeResult == false &&
                                                    commentlike[widget.card.commentId] == true) {
                                                  //누르기
                                                  commentlikecnt[widget.card.commentId] =
                                                      commentlikecnt[widget.card.commentId]! + 1;
                                                } else {
                                                  //해당화면에서 상태변경취소
                                                  commentlikecnt[widget.card.commentId] = widget.card.commentLike;
                                                }
                                              });
                                            } else {
                                              setState(() {
                                                commentlike[widget.card.commentId] = true;
                                                commentlikecnt[widget.card.commentId] = 1;
                                              });
                                            }
                                            // 댓글좋아요
                                            PostCommentLike(widget.postId, widget.card.commentId);
                                          },
                                          icon: commentlike[widget.card.commentId] == true
                                              ? Icon(Icons.favorite)
                                              : Icon(Icons.favorite_border),
                                          constraints: BoxConstraints(),
                                          padding: EdgeInsets.zero,
                                        ),
                                        SizedBox(width: 2.w),
                                        Text('${commentlikecnt[widget.card.commentId] ?? 0}'),
                                        SizedBox(width: 5.w),
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            onPressed: () {
                                              select = widget.card.commentId;
                                              widget.changeinputtarget();
                                            },
                                            icon: Icon(Icons.chat_bubble_outline)),
                                        SizedBox(width: 2.w),
                                        Text('${widget.card.countReply}'),
                                      ],
                                    ),
                                  ])
                                ],
                              ),
                            )
                          ])))),
              widget.card.countReply > replycardd.length
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
                        List<replycard> cards = await GetReplyPlus(
                            widget.postId,
                            widget.card.commentId,
                            widget.card.replies[0]['replyId']);
                        setState(() {
                          replycardd.insertAll(0, cards.map<ReplyCard>((a) => ReplyCard(
                                        replyId: a.replyId,
                                        replyNickname: a.replyNickname,
                                        reply: a.reply,
                                        replyAnonymityNickname:
                                            a.replyAnonymityNickname,
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
          }
            );}});
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
}
