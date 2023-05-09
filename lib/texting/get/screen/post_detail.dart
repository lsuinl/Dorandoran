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
import 'package:dorandoran/texting/get/quest/post_detail_plus_comment.dart';
class PostDetail extends StatefulWidget {
  final int postId;

  const PostDetail({
    required this.postId,
    Key? key}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

int select = 0;
List<CommentCard> commentlist=[];
int plusreply=-1;

class _PostDetailState extends State<PostDetail> {
  DateTime commenttime =new DateTime.now().copyWith(year: 2022);

  int number = 1;
  int selectcommentid = 0;
  ScrollController scrollController=ScrollController();
  @override
  @override
  void initState() {
    super.initState();
      commentlist=[];
  }


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

                        if (e.postNickname == 'nickname7') //익명/닉네임중복방지
                          postcommentstate = e.postAnonymity;
                        returncommentlist() async {
                          CommentCard duplicatcheck=
                          CommentCard(
                            commentCheckDelete: e.commentDetailDto[0]['commentCheckDelete'],
                            commentId: e.commentDetailDto[0]['commentId'],
                            commentAnonymityNickname: e.commentDetailDto[0]['commentAnonymityNickname'],
                            comment: e.commentDetailDto[0]['comment'],
                            commentLike: e.commentDetailDto[0]['commentLike'],
                            commentLikeResult: e.commentDetailDto[0]['commentLikeResult'],
                            replies: e.commentDetailDto[0]['replies'],
                            commentNickname: e.commentDetailDto[0]['commentNickname'],
                            commentTime: e.commentDetailDto[0]['commentTime'],
                            postId: widget.postId,
                            changeinputtarget: changeinputtarget,
                            deletedreply: deletereply,
                          );

                           if(commentlist.length<10 || (commentlist[commentlist.length-10].commentId!=duplicatcheck.commentId)) {
                             commentlist.insertAll( //await해야될듯
                                 0,e.commentDetailDto.map<CommentCard>((a) =>
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
                                     )).toList());
                           }
                            //불러올 댓글갯수가 더 남아있다면
                                plusreply=commentlist.length<e.commentCnt? commentlist[commentlist.length-10].commentId: -1;

                          //이미 쓴 댓글 익명여부 검사
                          for (final a in e.commentDetailDto) {
                            //댓글 작성자
                            if (a["commentNickname"] == "nickname7" &&
                                a["commentCheckDelete"] == false)
                              postcommentstate =
                              a["commentAnonymityNickname"] == null
                                  ? false
                                  : true;
                            for (final b in a["replies"]) {
                              if (b["replyNickname"] == "nickname7" &&
                                  b["replyCheckDelete"] == false)
                                postcommentstate =
                                b["replyAnonymityNickname"] == null
                                    ? false
                                    : true;
                            };
                          };
                        }

                        returncommentlist();
                        return Container(
                            alignment: Alignment.topCenter,
                            decoration: gradient,
                            child: Column(
                                children: [
                                  Expanded(child:
                                  ListView(
                                    controller: scrollController,
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
                                      plusreply==-1 ? Container()
                                          :ElevatedButton(onPressed: () async {
                                        List<dynamic> pluscomments= await PlusComment(50, plusreply, '7@gmail.com');
                                          commentlist.insertAll(0, pluscomments.map<CommentCard>((a) =>
                                              CommentCard(
                                                commentCheckDelete: a.commentCheckDelete,
                                                commentId: a.commentId,
                                                commentAnonymityNickname: a.commentAnonymityNickname,
                                                comment: a.comment,
                                                commentLike: a.commentLike,
                                                commentLikeResult: a.commentLikeResult,
                                                replies: a.replies,
                                                commentNickname: a.commentNickname,
                                                commentTime: a.commentTime,
                                                postId: widget.postId,
                                                changeinputtarget: changeinputtarget,
                                                deletedreply: deletereply,
                                              )).toList());
                                        //중복체크해서 삽입
                                      //불러올 댓글갯수가 더 남아있다면
                                          setState(() {
                                            plusreply=commentlist.length<e.commentCnt? commentlist[0].commentId: -1;
                                          });

                                      },
                                          child: Text("댓글 더보기")),
                                      ListBody(
                                          children: commentlist ??
                                              [Center(child: Card(child: SizedBox(
                                                      height: 300.h,
                                                      width: 350.w,
                                                      child: Center(
                                                        child: Text("작성된 댓글이 없습니다"),
                                                      )
                                                  )
                                              )
                                          )]
                                      ),
                                    ],
                                  )),
                                  InputComment(
                                    postId: widget.postId,
                                    postcommentstate: postcommentstate,
                                    commentId: selectcommentid,
                                    sendmessage: sendmessage,
                                    reset: changeinputtarget,),
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
    if (DateTime.now()
        .difference(commenttime)
        .inSeconds > 5) {
        if (selectcommentid == 0) { //댓글
          commenttime = await postcomment(
              widget.postId, useremail, controller.text, anonymity);
        }
        else { //대댓글
          commenttime = await postreply(
              selectcommentid, useremail, controller.text, anonymity);
        }
        print(anonymity);
    setState(() {
      controller.clear();
      number = number;
      commenttime=DateTime.now();
    });
      //  final position = scrollController.position.maxScrollExtent;
      //  scrollController.jumpTo(position);
    }
    else{
    print("도배하지마쇼");
    showDialog(
    context: context,
    barrierDismissible: false, // 바깥 영역 터치시 닫을지 여부
    builder: (BuildContext context) {
    return AlertDialog(
    backgroundColor: Colors.white,
    content: const Text("천천히 댓글을 작성하시오,,"),
    actions: [
    TextButton(
    child: const Text('확인',
    style: TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w700)),
    onPressed: () {
      Navigator.pop(context);
    },
    ),
    ],
    );
    });
    //5초미만의 간격으로 댓글 작성시
    // 경고 문구와함께 댓글이 쳐지지 않음
    }
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