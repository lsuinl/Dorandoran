import 'package:dorandoran/common/css.dart';
import 'package:dorandoran/texting/post_datail/component/post_detail_inputcomment.dart';
import 'package:dorandoran/texting/post_datail/model/commentcard.dart';
import 'package:dorandoran/texting/post_datail/model/postcard_detaril.dart';
import 'package:dorandoran/texting/post_datail/quest/post_detail_get_detailcard.dart';
import 'package:dorandoran/texting/post_datail/quest/post_detail_postcomment.dart';
import 'package:dorandoran/texting/post_datail/quest/post_detail_postreply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'component/post_detail_card.dart';
import 'component/post_detaili_commentcard.dart';
import 'package:dorandoran/texting/post_datail/quest/post_detail_plus_comment.dart';
import 'package:dorandoran/common/basic.dart';

class PostDetail extends StatefulWidget {
  final int postId;

  const PostDetail({required this.postId, Key? key}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

List<CommentCard> commentlist = [];
int select = 0;
int plusreply = -1;
int replycnt = 0;

class _PostDetailState extends State<PostDetail> {
  DateTime commenttime = new DateTime.now().copyWith(year: 2022);
  int number = 1;
  int selectcommentid = 0;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    commentlist = [];
  }

  @override
  Widget build(BuildContext context) {
    return Basic(
        widgets: FutureBuilder(
            future: getpostDetail(widget.postId, ""),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                dynamic e = snapshot.data!;
                bool? postcommentstate;
                if (e.postNickname == 'nickname7') //익명/닉네임중복방지
                  postcommentstate = e.postAnonymity;
                if(commentlist.length<1){
                  commentlist.addAll(e.commentDetailDto.map<CommentCard>((a) => CommentCard(
                    card: commentcard(
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
                    deletedreply: deletereply,
                  )).toList());
                }

                  List<CommentCard> newlist= e.commentDetailDto.map<CommentCard>((a) => CommentCard(
                      card: commentcard(
                    commentCheckDelete: a['commentCheckDelete'],
                    commentId: a['commentId'],
                    commentAnonymityNickname: a['commentAnonymityNickname'],
                    comment: a['comment'],
                    commentLike: a['commentLike'],
                    commentLikeResult: a['commentLikeResult'],
                    replies: a['replies'],
                    isWrittenByMember: a['isWrittenByMember'],
                    commentNickname: a['commentNickname'],
                    commentTime: a['commentTime'],
                        countReply: a['countReply'],
                      ),
                    postId: widget.postId,
                    changeinputtarget: changeinputtarget,
                    deletedreply: deletereply,
                  )).toList();

                //***** 대댓글 중복체크하기
                  //중복체크 후
                  newlist.forEach((element) { //새로운리스트와 기존리스트비교
                      for(int i=0;i<commentlist.length;i++){
                        if(commentlist[i].card.commentId==element.card.commentId
                        &&   commentlist[i].card.commentCheckDelete==element.card.commentCheckDelete
                        &&   commentlist[i].card.commentLikeResult==element.card.commentLikeResult
                        &&   commentlist[i].card.commentLike==element.card.commentLike
                        &&   commentlist[i].card.replies==element.card.replies
                        )
                        { //같은거발견
                          break;
                        }
                        else if(commentlist[i].card.commentId==element.card.commentId) { //같은데 내용 바뀐거.
                          commentlist[i]=element;
                          break;
                        }
                        else if(i+1==commentlist.length){ //끝까지 같은거없었으면
                          commentlist.add(element);
                        }
                    }
                  });

                  //불러올 댓글갯수가 더 남아있다면
                  int count = 0;
                  commentlist.forEach((CommentCard reply) => count += reply.card.countReply);
                  plusreply = (commentlist.length + count) < e.commentCnt ?
                  commentlist[0].card.commentId : -1;
                  //이미 쓴 댓글 익명여부 검사
                  for (final a in e.commentDetailDto) {
                    //댓글 작성자
                    if (a["commentNickname"] == "nickname7" && a["commentCheckDelete"] == false)
                      postcommentstate = a["commentAnonymityNickname"] == null ? false : true;
                    for (final b in a["replies"])
                      if (b["replyNickname"] == "nickname7" && b["replyCheckDelete"] == false)
                        postcommentstate = b["replyAnonymityNickname"] == null ? false : true;
                  };

                return Container(
                    alignment: Alignment.topCenter,
                    decoration: gradient,
                    child: Column(children: [
                      Expanded(
                          child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        children: [
                          Detail_Card(
                            postId: widget.postId,
                            card: postcardDetail(
                            postNickname: e.postNickname,
                            postAnonymity: e.postAnonymity,
                            content: e.content,
                            postTime: e.postTime,
                            isWrittenByMember: e.isWrittenByMember,
                            checkWrite: e.checkWrite,
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
                              commentDetailDto: e.commentDetailDto,
                            )
                          ),
                          SizedBox(height: 10.h),
                          plusreply == -1
                              ? Container()
                              : OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      elevation: 2,
                                      //minimumSize: Size(100.w, 30.h),
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                      backgroundColor: Color(0xFFBDBDBD),
                                      side: BorderSide(
                                        color: Color(0xFFFFFFFF),
                                        width: 1.0,
                                      )),
                                  onPressed: () async {
                                    List<dynamic> pluscomments = await PlusComment(50, plusreply);
                                    commentlist.insertAll(0, pluscomments.map<CommentCard>((a) =>
                                                CommentCard(
                                                  card: commentcard(
                                                  commentCheckDelete: a.commentCheckDelete,
                                                  isWrittenByMember: a.isWrittenByMember,
                                                  commentId: a.commentId,
                                                  commentAnonymityNickname: a.commentAnonymityNickname,
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
                                                  deletedreply: deletereply,
                                                )).toList());
                                    //중복체크해서 삽입
                                    //불러올 댓글갯수가 더 남아있다면
                                    setState(() {
                                      int count = 0;
                                      commentlist.forEach((CommentCard reply) => count += reply.card.countReply);
                                      plusreply = (commentlist.length + count) < e.commentCnt ?
                                      commentlist[0].card.commentId : -1;
                                    });
                                  },
                                  child: Text("댓글 더보기",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!)),
                          ListBody(
                              children: commentlist.length >0 ? commentlist:
                                  [
                                    Center(
                                        child: Card(
                                            child: SizedBox(
                                                height: 300.h,
                                                width: 350.w,
                                                child: Center(
                                                  child: Text("작성된 댓글이 없습니다"),
                                                ))))
                                  ]),
                        ],
                      )),
                      InputComment(
                        postId: widget.postId,
                        postcommentstate: postcommentstate,
                        commentId: selectcommentid,
                        sendmessage: sendmessage,
                        reset: changeinputtarget,
                      ),
                    ]));
              } else {
                return Container(
                    decoration: gradient,
                    child: Center(child: CircularProgressIndicator()));
              }
            }));
  }

  sendmessage() async {
    if (DateTime.now().difference(commenttime).inSeconds > 5) {
      if (selectcommentid == 0) {
        //댓글
        commenttime = await postcomment(
            widget.postId, controller.text, anonymity,lockcheck);
      } else {
        //대댓글
        commenttime = await postreply(
            selectcommentid, controller.text, anonymity,lockcheck);
      }
      setState(() {
        controller.clear();
        number = number;
        selectcommentid=0;
        commenttime = DateTime.now();
      });
      //  final position = scrollController.position.maxScrollExtent;
      //  scrollController.jumpTo(position);
    } else {
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