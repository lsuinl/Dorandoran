import 'package:dorandoran/common/css.dart';
import 'package:dorandoran/common/quest_token.dart';
import 'package:dorandoran/texting/post_datail/component/post_detail_inputcomment.dart';
import 'package:dorandoran/texting/post_datail/model/commentcard.dart';
import 'package:dorandoran/texting/post_datail/model/postcard_detaril.dart';
import 'package:dorandoran/texting/post_datail/quest/post/delete_postdetail_post_delete.dart';
import 'package:dorandoran/texting/post_datail/quest/post/post_postdetail_post_detail.dart';
import 'package:dorandoran/texting/post_datail/quest/comment/post_postdetail_comment.dart';
import 'package:dorandoran/texting/post_datail/quest/reply/post_postdetail_reply.dart';
import 'package:dorandoran/texting/post_datail/quest/report/post_report_post.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_icons/solar_icons.dart';
import '../home/home.dart';
import 'component/post_detail_card.dart';
import 'component/post_detaili_commentcard.dart';
import 'package:dorandoran/texting/post_datail/quest/comment/get_postdetail_plus_comment.dart';
import 'package:dorandoran/common/basic.dart';

import 'model/replycard.dart';
import 'quest/post/post_block_member.dart';

class PostDetail extends StatefulWidget {
  final int postId;
  final postcardDetail e;

  const PostDetail({required this.postId, required this.e, Key? key})
      : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

int select = 0;
int number = 1;
int selectcommentid = 0;
DateTime commenttime = new DateTime.now().copyWith(year: 2022);
ScrollController scrollController = ScrollController();

class _PostDetailState extends State<PostDetail> {
  int plusreply = -1;
  int replycnt = 0;
  List<String> _menulist = ['신고하기', '차단하기'];
  bool postcommentstate = false;
  bool isExistNextComment = false;
  List<CommentCard> commentlist = [];
  List<CommentCard> pluscomments = [];

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      dataset();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Basic(
        widgets: Container(
            alignment: Alignment.topCenter,
            decoration: gradient,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                              (route) => false),
                          icon: Icon(
                            SolarIconsOutline.doubleAltArrowLeft,
                            size: 30.r,
                          )),
                      Text(
                        "${widget.e.postAnonymity == true ? "익명" : widget.e.postNickname}",
                        style: GoogleFonts.nanumGothic(
                            fontSize: 20.sp, fontWeight: FontWeight.w800),
                      ),
                      DropdownButton2(
                          customButton:
                              Icon(SolarIconsOutline.sirenRounded, size: 24.r),
                          dropdownWidth: 150,
                          dropdownDirection: DropdownDirection.left,
                          items: [
                            ..._menulist.map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            if (value == "삭제하기")
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  // 바깥 영역 터치시 닫을지 여부
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text("작성한 글을 삭제하시겠습니까?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!),
                                      actions: [
                                        TextButton(
                                          child: Text('확인',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!),
                                          onPressed: () async {
                                            await DeletePostDelete(
                                                widget.postId);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Home())).then(
                                                (value) => setState(() {}));
                                          },
                                        ),
                                        TextButton(
                                            child: Text('취소',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!),
                                            onPressed: () =>
                                                Navigator.of(context).pop()),
                                      ],
                                    );
                                  });
                            if (value == "신고하기") {
                              showDialog(
                                  barrierColor: Colors.white70,
                                  context: context,
                                  barrierDismissible: true,
                                  // 바깥 영역 터치시 닫을지 여부
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        elevation: 0,
                                        title: Center(child: Text("신고항목 선택")),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          side:
                                              BorderSide(color: Colors.black26),
                                        ),
                                        content: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.black12),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      minimumSize: Size(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                          0)),
                                                  onPressed: () {
                                                    sendreport('선정성');
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(" 1.선정성",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!)),
                                              Container(
                                                  height: 2,
                                                  color: Colors.black12),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      minimumSize: Size(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                          0)),
                                                  onPressed: () {
                                                    sendreport('폭력성');
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(" 2.폭력성",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!)),
                                              Container(
                                                  height: 2,
                                                  color: Colors.black12),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      minimumSize: Size(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                          0)),
                                                  onPressed: () {
                                                    sendreport('욕설 및 비방');
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(" 3.욕설 및 비방",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!)),
                                              Container(
                                                  height: 2,
                                                  color: Colors.black12),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      minimumSize: Size(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                          0)),
                                                  onPressed: () {
                                                    sendreport('광고');
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(" 4.광고",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!)),
                                              Container(
                                                  height: 2,
                                                  color: Colors.black12),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      minimumSize: Size(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                          0)),
                                                  onPressed: () {
                                                    sendreport('불건전한 만남 유도');
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(" 5.불건전한 만남 유도",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!)),
                                              Container(
                                                  height: 2,
                                                  color: Colors.black12),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      minimumSize: Size(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                          0)),
                                                  onPressed: () {
                                                    sendreport('불건전한 닉네임');
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(" 6.불건전한 닉네임",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!)),
                                              Container(
                                                  height: 2,
                                                  color: Colors.black12),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      minimumSize: Size(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                          0)),
                                                  onPressed: () {
                                                    sendreport('기타');
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(" 7.기타",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!)),
                                            ],
                                          ),
                                        ));
                                  });
                            }
                            if (value == "차단하기") {
                              PostBlockMember("post", widget.postId);
                              Navigator.pop(context);
                              Fluttertoast.showToast(msg: "해당 사용자가 차단되었습니다.");
                            }
                          })
                    ]),
              ),
              Expanded(
                  child: ListView(
                controller: scrollController,
                padding: EdgeInsets.zero,
                children: [
                  Detail_Card(
                      postId: widget.postId,
                      card: postcardDetail(
                          postNickname: widget.e.postNickname,
                          postAnonymity: widget.e.postAnonymity,
                          content: widget.e.content,
                          postTime: widget.e.postTime,
                          isWrittenByMember: widget.e.isWrittenByMember,
                          checkWrite: widget.e.checkWrite,
                          location: widget.e.location,
                          postLikeCnt: widget.e.postLikeCnt,
                          postLikeResult: widget.e.postLikeResult,
                          commentCnt: widget.e.commentCnt,
                          backgroundPicUri: widget.e.backgroundPicUri,
                          postHashes: widget.e.postHashes,
                          font: widget.e.font,
                          fontBold: widget.e.fontBold,
                          fontColor: widget.e.fontColor,
                          fontSize: widget.e.fontSize,
                          commentDetailDto: widget.e.commentDetailDto,
                          isExistNextComment: widget.e.isExistNextComment)),
                  isExistNextComment == false
                      ? Container()
                      : OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              elevation: 2,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black26
                                  : Color(0xFFBDBDBD),
                              side: BorderSide(
                                color: Color(0xFFFFFFFF),
                                width: 1.0,
                              )),
                          onPressed: () async {
                            dynamic plusdata =
                                await GetCommentPlus(widget.postId, plusreply);
                            if (pluscomments.length > 0)
                              commentlist.insertAll(0, pluscomments);
                            List<dynamic> pluscommentsmodel =
                                plusdata['commentData']
                                    .map((dynamic e) => commentcard.fromJson(e))
                                    .toList();
                            pluscomments = pluscommentsmodel
                                .map<CommentCard>((a) => CommentCard(
                                      card: commentcard(
                                        isLocked: a.isLocked,
                                        commentCheckDelete:
                                            a.commentCheckDelete,
                                        isWrittenByMember: a.isWrittenByMember,
                                        commentId: a.commentId,
                                        commentAnonymityNickname:
                                            a.commentAnonymityNickname,
                                        comment: a.comment,
                                        commentLike: a.commentLike,
                                        commentLikeResult: a.commentLikeResult,
                                        replies: a.replies,
                                        commentNickname: a.commentNickname,
                                        commentTime: a.commentTime,
                                        countReply: a.countReply,
                                      ),
                                      postId: widget.postId,
                                      changeinputtarget: changeinputtarget,
                                      setstates: deletereply,
                                    ))
                                .toList();
                            print(pluscomments
                                .map((e) => e.card.commentId)
                                .toList());
                            print(commentlist
                                .map((e) => e.card.commentId)
                                .toList());
                            //불러올 댓글갯수가 더 남아있다면
                            plusreplys(plusdata['isExistNextComment'],
                                widget.e.commentCnt, pluscomments);
                          },
                          child: Text("댓글 더보기",
                              style:
                                  Theme.of(context).textTheme.headlineMedium!)),
                  commentlist.length > 0
                      ? SingleChildScrollView(
                          child: Column(
                          children: pluscomments + commentlist,
                        ))
                      :
                      Center(child:
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                          child: Text("작성된 댓글이 없습니다")),
                        )
                ],
              )),
              InputComment(
                postId: widget.postId,
                postcommentstate: postcommentstate,
                commentId: selectcommentid,
                sendmessage: sendmessage,
                reset: changeinputtarget,
              ),
            ])));
  }

  sendmessage() async {
    if (DateTime.now().difference(commenttime).inSeconds > 5) {
      if (selectcommentid == 0) {
        //댓글
        commenttime = await PostComment(
            widget.postId, controller.text, anonymity, lockcheck);
      } else {
        //대댓글
        commenttime = await PostReply(
            selectcommentid, controller.text, anonymity, lockcheck);
      }
      if (commenttime == 403) Fluttertoast.showToast(msg: "작성이 정지된 상태입니다.");
      setState(() {
        controller.clear();
        number = number;
        selectcommentid = 0;
        commenttime = DateTime.now();
      });
      postcardDetail e = await PostPostDetail(widget.postId, "");
      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostDetail(postId: widget.postId, e: e)));
    } else {
      showDialog(
          context: context,
          barrierDismissible: false, // 바깥 영역 터치시 닫을지 여부
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black87
                  : Color(0xFFD9D9D9),
              content: Text("천천히 댓글을 작성하시오..",
                  style: Theme.of(context).textTheme.headlineMedium!),
              actions: [
                TextButton(
                  child: Text('확인',
                      style: Theme.of(context).textTheme.headlineMedium!),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      //5초미만의 간격으로 댓글 작성시 경고 문구와함께 댓글이 쳐지지 않음
    }
  }

  dataset() {
    setState(() {
      isExistNextComment = widget.e.isExistNextComment;

      if (widget.e.isWrittenByMember == true) _menulist = ['삭제하기'];

      if (widget.e.isWrittenByMember == true) //익명체크. 작성자용
        postcommentstate = widget.e.postAnonymity;

      commentlist = widget.e.commentDetailDto
          .map<CommentCard>((a) => CommentCard(
                //댓글추가
                card: commentcard(
                  isLocked: a['isLocked'],
                  commentCheckDelete: a['commentCheckDelete'],
                  commentId: a['commentId'],
                  isWrittenByMember: a['isWrittenByMember'],
                  commentAnonymityNickname: a['commentAnonymityNickname'],
                  comment: a['comment'],
                  commentLike: a['commentLike'],
                  commentLikeResult: a['commentLikeResult'],
                  replies: a['replies'],
                  commentNickname: a['commentNickname'],
                  commentTime: a['commentTime'],
                  countReply: a['countReply'],
                ),
                postId: widget.postId,
                changeinputtarget: changeinputtarget,
                setstates: deletereply,
              ))
          .toList();

      //불러올 댓글갯수가 더 남아있다면
      int count = 0;
      commentlist
          .forEach((CommentCard reply) => count += reply.card.countReply);
      plusreply = commentlist.length > 0 ? commentlist[0].card.commentId : -1;

      for (final a in widget.e.commentDetailDto) {
        //이미 쓴 댓글 익명여부 검사
        //댓글 작성자
        if (a["isWrittenByMember"] == true && a["commentCheckDelete"] == false)
          postcommentstate =
              a["commentAnonymityNickname"] == null ? false : true;
        for (final b in a["replies"]['replyData'])
          if (b["isWrittenByMember"] == true && b["replyCheckDelete"] == false)
            postcommentstate =
                b["replyAnonymityNickname"] == null ? false : true;
      }
    });
  }

  plusreplys(bool isExistNextComments, int commentCnt, pluscomment) {
    setState(() {
      pluscomments = pluscomment;
      int count = 0;
      isExistNextComment = isExistNextComments;
      commentlist
          .forEach((CommentCard reply) => count += reply.card.countReply);
      plusreply = (commentlist.length + count) < commentCnt
          ? commentlist[0].card.commentId
          : -1;
    });
  }

  changeinputtarget() {
    setState(() {
      selectcommentid = select;
    });
  }

  sendreport(String name) async {
    //신고하기
    int num = await PostReportPost(widget.postId, name);
    if (num == 201) Fluttertoast.showToast(msg: "신고가 접수되었습니다.");
  }

  deletereply() {
    //대댓글삭제
    setState(() {});
  }
}
