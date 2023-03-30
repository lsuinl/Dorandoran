import 'package:dorandoran/common/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/util.dart';
import '../quest/post_detail_deletereply.dart';

class ReplyCard extends StatelessWidget {
  final int replyId;
  final String replyNickname;
  final String reply;
  final String? replyAnonymityNickname;
  final bool replyAnonymity;
  final bool replyCheckDelete;
  final String replyTime;
  final VoidCallback deletedreply;

  const ReplyCard({
    required this.replyId,
    required this.replyNickname,
    required this.reply,
    required this.replyAnonymityNickname,
    required this.replyAnonymity,
    required this.replyCheckDelete,
    required this.replyTime,
    required this.deletedreply,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child:Row(
       children:[
        SizedBox(width: 10.w),
        Icon(Icons.subdirectory_arrow_right_outlined,size: 30,),
         Expanded(
         child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            elevation: 4, //그림자
            child: Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child:
                Row(
                    children:[
                      SizedBox(width: 10.w),
                      Icon(Icons.person, size: 50.r,),
                      Expanded(child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        replyCheckDelete ?
                        Text("삭제",
                          style: GoogleFonts.jua(),) :
                          Row(
                            children: [
                              Expanded(child:Text( replyAnonymityNickname ?? replyNickname ,style: GoogleFonts.jua(fontSize: 17.sp),), ),
                              "nickname7" == replyNickname
                                  ? TextButton(
                                onPressed:() async {
                                  await deletereply(replyId,useremail);
                                  deletedreply();
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
                                  : Container(),
                            ],
                          ),
                          Text(replyCheckDelete?"!삭제된 댓글입니다!" :reply!, style: GoogleFonts.jua(),),
                          Row(
                              children: [
                                Text(timecount(replyTime),style: TextStyle(fontSize: 12.sp),),
                                SizedBox(width: 160.w,),
                              ]
                          )
                        ],
                      ),)
                    ]
                )
            )
        )
         )
       ]
        ));
  }
}

