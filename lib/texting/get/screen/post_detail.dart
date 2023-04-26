import 'package:dorandoran/common/css.dart';
import 'package:dorandoran/common/storage.dart';
import 'package:dorandoran/texting/get/component/post_detail_inputcomment.dart';
import 'package:dorandoran/texting/get/quest/post_detail_get_detailcard.dart';
import 'package:dorandoran/texting/get/quest/post_detail_postcomment.dart';
import 'package:dorandoran/texting/get/quest/post_detail_postreply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../component/post_detail_card.dart';
import '../component/post_detaili_commentcard.dart';

class PostDetail extends StatefulWidget {
  final int postId;

  const PostDetail({
    required this.postId,
    Key? key}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

int select = 0;

class _PostDetailState extends State<PostDetail> {
  int number = 1;
  int selectcommentid = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: gradient,
            child: SafeArea(
                top: false,
                bottom: true,
                child: FutureBuilder(
                    future: getpostDetail(widget.postId, useremail, ""),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        dynamic e = snapshot.data!;
                        bool? postcommentstate;
                        late List<Widget> commentlist = [
                          Center(
                              child: Card(
                                  child: SizedBox(
                                      height: 300.h,
                                      width: 350.w,
                                      child: Center(
                                        child: Text("작성된 댓글이 없습니다"),
                                      )
                                  )
                              )
                          )
                        ];
                        if(e.postNickname=='nickname7') //익명/닉네임중복방지
                          postcommentstate=e.postAnonymity;
                        returncommentlist() async {
                          if (e.commentDetailDto != null)
                            commentlist = //await해야될듯
                            e.commentDetailDto.map<CommentCard>((a) =>
                                CommentCard(
                                  commentCheckDelete: a['commentCheckDelete'],
                                  commentId: a['commentId'],
                                  commentAnonymityNickname: a['commentAnonymityNickname'],
                                  comment: a['comment'],
                                  commentLike: a['commentLike'],
                                  commentLikeResult: a['commentLikeResult'],
                                  replies: a['replies'],
                                  commentNickname: a['commentNickname'],
                                  commentTime: a['commentTime'],
                                  postId: widget.postId,
                                  changeinputtarget: changeinputtarget,
                                  deletedreply: deletereply,
                                )).toList();
                          //댓글 검사
                          // e.commentDetailDto.map((a){
                          //   print("dddd");
                          //   if(a['commentNickname']==useremail && a['commentCheckDelete']==true)
                          //     postcommentstate = a['commentAnonymityNickname'] != null ? true : false;
                          //   if (a['replies'] != null)
                          //     a['replies'].map((b) {
                          //       if (a['commentNickname'] == useremail &&
                          //           a['commentCheckDelete'] == true)
                          //         postcommentstate =
                          //         a['commentAnonymityNickname'] != null
                          //             ? true
                          //             : false;
                          //     }
                          //     );
                          // }
                          // );
                            //이미 쓴 댓글 익명여부 검사
                          for(final a in e.commentDetailDto) {
                              //댓글 작성자
                              if (a["commentNickname"] == "nickname7" &&
                                  a["commentCheckDelete"] == false)
                                postcommentstate =
                                a["commentAnonymityNickname"] == null
                                    ? false
                                    : true;
                              for(final b in a["replies"]) {
                                if (b["replyNickname"] == "nickname7" &&
                                    b["replyCheckDelete"] == false)
                                  postcommentstate =
                                  b["replyAnonymityNickname"] == null
                                      ? false
                                      : true;
                              };
                            };
                        }

                        // checkanaoyed(){
                        //   //이미 쓴 댓글 익명여부 검사
                        //   e.commentDetailDto.map((a) {
                        //     //댓글 작성자
                        //     if (a["commentNickname"] == "nickname7" &&
                        //         a["commentCheckDelete"] == false)
                        //       postcommentstate =
                        //       a["commentAnonymityNickname"] == null
                        //           ? false
                        //           : true;
                        //     print("실행되고는있니");
                        //     a.replies.map((b) {
                        //       if (b["replyNickname"] == "nickname7" &&
                        //           b["replyCheckDelete"] == false)
                        //         postcommentstate =
                        //         b["replyAnonymityNickname"] == null
                        //             ? false
                        //             : true;
                        //     });
                        //   });
                        // }
                        returncommentlist();
                        return Container(
                            alignment: Alignment.topCenter,
                            decoration: gradient,
                            child: Column(
                                children: [
                                  Expanded(child:
                                  ListView(
                                    padding: EdgeInsets.zero,
                                    children: [
                                      Detail_Card(
                                        postNickname: e.postNickname,
                                        postAnonymity: e.postAnonymity,
                                        postId: widget.postId,
                                        content: e.content,
                                        postTime: e.postTime,
                                        location: e.location,
                                        postLikeCnt: e.postLikeCnt,
                                        postLikeResult: e.postLikeResult,
                                        commentCnt: e.commentCnt,
                                        backgroundPicUri: e.backgroundPicUri,
                                        postHashes: e.postHashes,
                                        font: e.font,
                                        fontBold: e.fontBold,
                                        fontColor: e.fontColor,
                                        fontSize: e.fontSize,
                                      ),
                                      SizedBox(height: 10.h),
                                      ListBody(
                                          children: commentlist
                                      ),
                                    ],
                                  )),
                                  InputComment(postId: widget.postId,
                                    postcommentstate: postcommentstate,
                                    commentId: selectcommentid,
                                    sendmessage: sendmessage,
                                    reset: changeinputtarget,)
                                ]
                            )
                        );
                      }
                      else {
                        return Container(
                            decoration: gradient,
                            child: Center(child: CircularProgressIndicator()));
                      }
                    }
                )
            )));
  }

  sendmessage() async {
    if (selectcommentid == 0) { //댓글
      await postcomment(widget.postId, useremail, controller.text, anonymity);
    }
    else { //대댓글
      await postreply(selectcommentid, useremail, controller.text, anonymity);
    }
    print(anonymity);
    setState(() {
      controller.clear();
      number = number;
    });
  }

  changeinputtarget() {
    setState(() {
      selectcommentid = select;
    });
  }

  deletereply() {
    setState(() {});
  }
}