import 'package:dorandoran/common/css.dart';
import 'package:dorandoran/common/storage.dart';
import 'package:dorandoran/texting/get/component/home_message_card.dart';
import 'package:dorandoran/texting/get/quest/get_post_detail.dart';
import 'package:dorandoran/texting/get/quest/like.dart';
import 'package:dorandoran/texting/write/component/write_middlefield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/util.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  int number=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getpostDetail(4,"7@gmail.com", ""),
            builder:(context, snapshot) {
              if(snapshot.hasData){
                dynamic e = snapshot.data!;
                return Container(
                    alignment: Alignment.topCenter,
                    decoration: gradient,
                    child:
                    ListView(
                        padding: EdgeInsets.zero,
                        children:[
                          Detail_Card(
                              postNickname: e.postNickname,
                              postId: 4,
                              content: e.content,
                              postTime: e.postTime,
                              location: e.location,
                              postLikeCnt: e.postLikeCnt,
                              postLikeResult: e.postLikeResult,
                              commentCnt: e.commentCnt,
                              backgroundPicUri: e.backgroundPicUri,
                              postHashes: e.postHashes
                          ),
                          SizedBox(height: 10.h),
                          ListBody(
                            children:
                            e.commentDetailDto.map<CommentCard>((a) =>
                                CommentCard(
                                    number: number,
                                    upnumber: upnumber,
                                    commentId: a['commentId'],
                                    comment: a['comment'],
                                    commentLike: a['commentLike'],
                                    commentLikeResult: a['commentLikeResult'],
                                    replies: a['replies'],
                                    commentNickname:a['commentNickname'],
                                    commentTime:a['commentTime']
                                )).toList(),
                          )
                        ]
                    )
                );
              }
              else{
                return Container(
                    decoration: gradient,
                    child: Center(child: CircularProgressIndicator()));
              }
            }
        )
    );
  }
  upnumber(){
    setState(() {
      number=number+1;
    });
  }
}


class Detail_Card extends StatefulWidget {
  final int postId;
  final String content;
  final String postTime;
  final String? location;
  final int postLikeCnt;
  final bool? postLikeResult;
  final int commentCnt;
  final String backgroundPicUri;
  final List<dynamic>? postHashes;
  final String postNickname;

  const Detail_Card({
    required this.postNickname,
    required this.postId,
    required this.content,
    required this.postTime,
    required this.location,
    required this.postLikeCnt,
    required this.postLikeResult,
    required this.commentCnt,
    required this.backgroundPicUri,
    required this.postHashes,
    Key? key}) : super(key: key);

  @override
  State<Detail_Card> createState() => _Detail_CardState();
}

bool like=false;
int likecnt=0;
class _Detail_CardState extends State<Detail_Card> {
  @override
  void initState() {
    super.initState();
    setState(() {
      like=widget.postLikeResult!;
      likecnt=widget.postLikeCnt;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [InkWell(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  image: DecorationImage(
                    image: NetworkImage('http://' + widget.backgroundPicUri),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  )),
              //BoxDecoration(image: DecorationImage(image:NetworkImage('http://'+backimg))),
              child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: BackButton(),
                      ),
                      SizedBox(
                        height: 450.h,
                        child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                             children:[ Text(widget.content,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 20.sp)),
                              SizedBox(height:20.h),
                              Text("by ${widget.postNickname}",
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12.sp)),
    ]
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.access_time_filled_rounded),
                              SizedBox(width: 3.w),
                              Text(timecount(widget.postTime)),
                              SizedBox(width: 7.w),
                              if (widget.location != null) Icon(Icons.place),
                              Text(widget.location == null ? '' : '${widget.location}km'),
                            ],
                          ),
                          Row( //하트버튼
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    like= !like;
                                  if(likecnt!=widget.postLikeResult && like==false) { //화면에서 취소누르면,,
                                    likecnt=likecnt-1;
                                  }
                                  else if(likecnt!=widget.postLikeResult && like==true){ //화면에서 좋아요
                                    likecnt=widget.postLikeCnt+1;
                                  }
                                  else{
                                    likecnt=widget.postLikeCnt;
                                  }
                                  });
                                  postLike(widget.postId, useremail!);
                                },
                                icon: like!
                                    ? Icon(Icons.favorite)
                                    : Icon(Icons.favorite_border),
                                constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                              SizedBox(width: 3.w),
                              Text('${likecnt}'),
                              SizedBox(width: 7.w),
                              Icon(Icons.forum),
                              SizedBox(width: 3.w),
                              Text('${widget.commentCnt}'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                    ],
                  )),
            ),
          ),
]
    );
  }
}

class CommentCard extends StatefulWidget {
  final int commentId;
  final String comment;
  final int commentLike;
  final bool commentLikeResult;
  final List<dynamic>? replies;
  final String? commentNickname;
  final String commentTime;
  final int number;
  final VoidCallback upnumber;

  const CommentCard({
    required this.commentId,
    required this.comment,
    required this.commentLike,
    required this.commentLikeResult,
    required this.replies,
    required this.commentNickname,
    required this.commentTime,
    required this.number,
    required this.upnumber,
    Key? key}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}
Map<int, bool> commentlike = {0: false};
Map<int, int> commentlikecnt = {0: 0};
class _CommentCardState extends State<CommentCard> {
  @override
  void initState() {
    if(widget.commentNickname==null) widget.upnumber();
    super.initState();
    setState(() {
      commentlike.addAll({widget.commentId: widget.commentLikeResult});
      commentlikecnt.addAll({widget.commentId: widget.commentLike});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    elevation: 2, //그림자
    child: Padding(padding: EdgeInsets.all(15),
    child:
    Row(
    children:[
      Icon(Icons.person, size: 50.r,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.commentNickname??"익명${widget.number}",style: GoogleFonts.jua(fontSize: 17.sp),),
          Text(widget.comment, style: GoogleFonts.jua(),),
        Row(
            children: [
              Row(
                children: [
                  Text(timecount(widget.commentTime),style: TextStyle(fontSize: 12.sp),),
                  SizedBox(width: 173.w),

                  Row( //하트버튼
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            commentlike[widget.commentId] = !commentlike[widget.commentId]!;
                            if (widget.commentLikeResult == true &&
                                commentlike[widget.commentId] == false) {
                              //눌린상태에서 취소
                              commentlikecnt[widget.commentId] =
                                  commentlikecnt[widget.commentId]! -1;
                            } else if (widget.commentLikeResult == false &&
                                commentlike[widget.commentId] == true) {
                              //누르기
                              commentlikecnt[widget.commentId] =
                                  commentlikecnt[widget.commentId]! + 1;
                            } else {
                              //해당화면에서 상태변경취소
                              commentlikecnt[widget.commentId] = widget.commentLike;
                            }
                            print(commentlikecnt[widget.commentId]);
                            print(commentlike[widget.commentId]);
                          });
                         // 댓글좋아요
                          //postLike(widget.postId, useremail!);
                        },
                        icon: commentlike[widget.commentId]!
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(width: 2.w),
                      Text('${commentlikecnt[widget.commentId]}'),
                      SizedBox(width: 5.w),
                      Icon(Icons.forum),
                      SizedBox(width: 3.w),
                      Text('${widget.replies!.length}'),
                    ],
                  ),
                ],
              ),
            ]
        )
        ],
      ),
        ]
    )
    )
    ));
  }
}
