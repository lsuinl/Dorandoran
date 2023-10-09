import 'package:dorandoran/common/css.dart';
import 'package:dorandoran/common/quest_token.dart';
import 'package:dorandoran/texting/post_datail/component/post_detail_inputcomment.dart';
import 'package:dorandoran/texting/post_datail/model/commentcard.dart';
import 'package:dorandoran/texting/post_datail/model/postcard_detaril.dart';
import 'package:dorandoran/texting/post_datail/quest/delete_postdetail_post_delete.dart';
import 'package:dorandoran/texting/post_datail/quest/post_postdetail_post_detail.dart';
import 'package:dorandoran/texting/post_datail/quest/post_postdetail_comment.dart';
import 'package:dorandoran/texting/post_datail/quest/post_postdetail_reply.dart';
import 'package:dorandoran/texting/post_datail/quest/report/post_report_post.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_icons/solar_icons.dart';
import '../home/home.dart';
import 'component/post_detail_card.dart';
import 'component/post_detaili_commentcard.dart';
import 'package:dorandoran/texting/post_datail/quest/get_postdetail_plus_comment.dart';
import 'package:dorandoran/common/basic.dart';

import 'model/replycard.dart';
import 'quest/post_block_member.dart';

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
List<String> _menulist = ['신고하기','차단하기'];

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
            future: PostPostDetail(widget.postId, ""),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                postcardDetail e = snapshot.data!;
                print(e.isExistNextComment);
                if(e.isWrittenByMember==true)
                  _menulist=['삭제하기'];
                bool? postcommentstate;
                if (e.isWrittenByMember == true) //익명체크. 작성자용
                  postcommentstate = e.postAnonymity;
                if(commentlist.length<1){
                  commentlist.addAll(e.commentDetailDto.map<CommentCard>((a) => CommentCard(
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
                    deletedreply: deletereply,
                  )).toList());
                }
                  List<CommentCard> newlist= e.commentDetailDto.map<CommentCard>((a) => CommentCard(
                      card: commentcard(
                        isLocked: a['isLocked'],
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
                    if (a["isWrittenByMember"] == true && a["commentCheckDelete"] == false)
                      postcommentstate = a["commentAnonymityNickname"] == null ? false : true;
                    for (final b in a["replies"]['replyData'])
                      if (b["isWrittenByMember"] == true && b["replyCheckDelete"] == false)
                        postcommentstate = b["replyAnonymityNickname"] == null ? false : true;
                  }

                return Container(
                    alignment: Alignment.topCenter,
                    decoration: gradient,
                    child: Column(
                        children: [
                    Padding(
                    padding: const EdgeInsets.all(10.0),
                  child:   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: ()=> Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home()))
                      .then((value) => setState(() {})), icon: Icon(SolarIconsOutline.doubleAltArrowLeft,size: 30.r,)),
                        Text("${e.postAnonymity==true ?"익명":e.postNickname}", style: GoogleFonts.nanumGothic(fontSize: 20.sp,fontWeight: FontWeight.w800),),
                        DropdownButton2(
                            customButton: Icon(SolarIconsOutline.sirenRounded,size: 24.r),
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
                              if(value=="삭제하기")
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    // 바깥 영역 터치시 닫을지 여부
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        content: const Text("작성한 글을 삭제하시겠습니까?"),
                                        actions: [
                                          TextButton(
                                            child: const Text('확인', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
                                            onPressed: () async {
                                              await DeletePostDelete(widget.postId);
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) => Home())).then((value) => setState(() {}));
                                            },
                                          ),
                                          TextButton(
                                              child: const Text('취소',
                                                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
                                              onPressed: () => Navigator.of(context).pop()
                                          ),
                                        ],
                                      );
                                    });
                              if(value=="신고하기"){
                                showDialog(
                                    barrierColor:Colors.white70,
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
                                          content:Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height/2,
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 2, color: Colors.black12),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                      alignment: Alignment.centerLeft,
                                                        minimumSize: Size(MediaQuery.of(context).size.width, 0)
                                                    ),
                                                    onPressed: ()=>sendreport('선정성'),
                                                    child: Text(" 1.선정성",style: TextStyle(fontSize: 15.sp,color: Colors.black87))),
                                                Container(height: 2,color: Colors.black12),
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                        alignment: Alignment.centerLeft,
                                                        minimumSize: Size(MediaQuery.of(context).size.width, 0)
                                                    ),
                                                    onPressed: ()=>sendreport('폭력성'),
                                                    child: Text(" 2.폭력성",style: TextStyle(fontSize: 15.sp,color: Colors.black87))),
                                                Container(height: 2,color: Colors.black12),
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                        alignment: Alignment.centerLeft,
                                                        minimumSize: Size(MediaQuery.of(context).size.width, 0)
                                                    ),
                                                    onPressed: ()=>sendreport('욕설 및 비방'),
                                                    child: Text(" 3.욕설 및 비방",style: TextStyle(fontSize: 15.sp,color: Colors.black87))),
                                                Container(height: 2,color: Colors.black12),
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                        alignment: Alignment.centerLeft,
                                                        minimumSize: Size(MediaQuery.of(context).size.width, 0)
                                                    ),
                                                    onPressed: ()=>sendreport('광고'),
                                                    child: Text(" 4.광고",style: TextStyle(fontSize: 15.sp,color: Colors.black87))),
                                                Container(height: 2,color: Colors.black12),
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                        alignment: Alignment.centerLeft,
                                                        minimumSize: Size(MediaQuery.of(context).size.width, 0)
                                                    ),
                                                    onPressed:()=>sendreport('불건전한 만남 유도'),
                                                    child: Text(" 5.불건전한 만남 유도",style: TextStyle(fontSize: 15.sp,color: Colors.black87))),
                                                Container(height: 2,color: Colors.black12),
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                        alignment: Alignment.centerLeft,
                                                        minimumSize: Size(MediaQuery.of(context).size.width, 0)
                                                    ),
                                                    onPressed:()=>sendreport('불건전한 닉네임'),
                                                    child: Text(" 6.불건전한 닉네임",style: TextStyle(fontSize: 15.sp,color: Colors.black87))),
                                                Container(height: 2,color: Colors.black12),
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                        alignment: Alignment.centerLeft,
                                                        minimumSize: Size(MediaQuery.of(context).size.width, 0)
                                                    ),
                                                    onPressed:()=>sendreport('기타'),
                                                    child: Text(" 7.기타",style: TextStyle(fontSize: 15.sp,color: Colors.black87))),
                                              ],
                                            ),
                                          )
                                      );
                                    });
                              }
                              if(value=="차단하기"){
                                PostBlockMember("post", widget.postId);
                                Fluttertoast.showToast(msg: "해당 사용자가 차단되었습니다.");
                              }
                            })
                      ]
                  ),),
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
                              isExistNextComment: e.isExistNextComment
                            )
                          ),
                        e.isExistNextComment==false
                              ? Container()
                              : OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      elevation: 2,
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                      backgroundColor: Color(0xFFBDBDBD),
                                      side: BorderSide(color: Color(0xFFFFFFFF), width: 1.0,)
                                  ),
                                  onPressed: () async {
                                    dynamic pluscomments = await GetCommentPlus(widget.postId, plusreply);
                                    commentlist.insertAll(0, pluscomments.map<CommentCard>((a) =>
                                                CommentCard(
                                                  card: commentcard(
                                                    isLocked: a.isLocked,
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
                                  child: Text("댓글 더보기", style: Theme.of(context).textTheme.headlineMedium!)),
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
        commenttime = await PostComment(widget.postId, controller.text, anonymity,lockcheck);
      } else {
        //대댓글
        commenttime = await PostReply(selectcommentid, controller.text, anonymity,lockcheck);
      }
      if(commenttime==403)
        Fluttertoast.showToast(msg: "작성이 정지된 상태입니다.");
      setState(() {
        controller.clear();
        number = number;
        selectcommentid=0;
        commenttime = DateTime.now();
      });
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
  sendreport(String name) async {
    int num=await PostReportPost(widget.postId,name);
    if(num==201)
      Fluttertoast.showToast(msg: "신고가 접수되었습니다.");
  }
  deletereply() {
    setState(() {});
  }
}