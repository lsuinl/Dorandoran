import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/util.dart';

class ReplyCard extends StatelessWidget {
  final int replyId;
  final String? replyNickname;
  final String reply;
  final String replyTime;
  final int number;

  const ReplyCard({
    required this.replyId,
    required this.replyNickname,
    required this.reply,
    required this.replyTime,
    required this.number,
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
                          Row(
                            children: [
                              Expanded(child:Text(replyNickname??"익명${number}",style: GoogleFonts.jua(fontSize: 17.sp),), ),
                              "nickname7" == replyNickname
                                  ? TextButton(
                                onPressed: () {},
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
                          Text(reply!, style: GoogleFonts.jua(),),
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

