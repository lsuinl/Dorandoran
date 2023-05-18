import 'package:dorandoran/common/storage.dart';
import 'package:dorandoran/texting/post_datail/model/replycard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/util.dart';
import '../quest/post_detail_deletereply.dart';

class ReplyCard extends StatelessWidget {
  final replycard card;
  final VoidCallback deletedreply;

  const ReplyCard({
    required this.card,
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
                          card.replyCheckDelete ?
                        Text("삭제",
                          style: GoogleFonts.jua(),) :
                          Row(
                            children: [
                              Expanded(child:Text(  card.replyAnonymityNickname ?? card.replyNickname ,style: GoogleFonts.jua(fontSize: 17.sp),), ),
                              "nickname7" ==  card.replyNickname
                                  ? TextButton(
                                onPressed:() {
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
                                                await deletereply( card.replyId,useremail);
                                                deletedreply();
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
                                  : Container(),
                            ],
                          ),
                          Text( card.replyCheckDelete?"!삭제된 댓글입니다!" : card.reply!, style: GoogleFonts.jua(),),
                          Row(
                              children: [
                                Text(timecount( card.replyTime),style: TextStyle(fontSize: 12.sp),),
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

