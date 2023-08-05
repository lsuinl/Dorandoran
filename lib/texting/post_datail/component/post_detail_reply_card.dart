import 'package:dorandoran/texting/post_datail/quest/delete_postdetail_reply_delete.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/util.dart';
import '../post_detail.dart';
import '../quest/post_block_member.dart';

class ReplyCard extends StatefulWidget {
  final int postId;
  final int replyId;
  final String replyNickname;
  final String reply;
  final String? replyAnonymityNickname;
  final bool replyCheckDelete;
  final String replyTime;
  final VoidCallback deletedreply;
  final bool isWrittenByMember;

  const ReplyCard(
      {required this.postId,
      required this.replyId,
      required this.replyNickname,
      required this.reply,
      required this.replyAnonymityNickname,
      required this.replyCheckDelete,
      required this.replyTime,
      required this.deletedreply,
      required this.isWrittenByMember,
      Key? key})
      : super(key: key);

  @override
  State<ReplyCard> createState() => _ReplyCardState();
}

late Future myfuture;

class _ReplyCardState extends State<ReplyCard> {
  @override
  Widget build(BuildContext context) {
    List<String> _menulist = ['신고하기', '차단하기'];
    if (widget.isWrittenByMember == true) _menulist = ['삭제하기'];
    return FutureBuilder(
        future: getnickname(),
        builder: (context, snapshot) {
          return Container(
              child: Row(children: [
            SizedBox(width: 10.w),
            Icon(Icons.subdirectory_arrow_right_outlined, size: 30,),
            Expanded(
                child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                    elevation: 4, //그림자
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Row(children: [
                          SizedBox(width: 10.w),
                          Icon(Icons.person, size: 50.r,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.replyCheckDelete
                                    ? Text("삭제", style: GoogleFonts.jua(),)
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.replyAnonymityNickname ??
                                                  widget.replyNickname,
                                              style: GoogleFonts.jua(
                                                  fontSize: 17.sp),
                                            ),
                                          ),
                                          DropdownButton2(
                                            customButton: Icon(Icons.more_vert),
                                            dropdownWidth: 150,
                                            dropdownDecoration: BoxDecoration(
                                                color: Colors.white),
                                            dropdownDirection:
                                                DropdownDirection.left,
                                            items: [
                                              ..._menulist.map(
                                                (item) =>
                                                    DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(item),
                                                ),
                                              ),
                                            ],
                                            onChanged: (value) {
                                              if (value == "삭제하기")
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            Colors.white,
                                                        content: const Text("작성한 대댓글을 삭제하시겠습니까?"),
                                                        actions: [
                                                          TextButton(
                                                            child: const Text(
                                                                '확인', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
                                                            onPressed: () async {
                                                              await DeleteReplyDelete(widget.replyId);
                                                              Navigator.push(context, MaterialPageRoute(
                                                                      builder: (context) => PostDetail(postId: widget.postId))).then((value) => setState(() {}));
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: const Text('취소', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
                                                            onPressed: ()=> Navigator.of(context).pop()
                                                          ),
                                                        ],
                                                      );
                                                    });
                                                if(value=="차단하기"){
                                                  PostBlockMember("reply", widget.replyId);
                                                  Fluttertoast.showToast(msg: "해당 사용자가 차단되었습니다.");
                                                }

                                            },
                                          ),
                                        ],
                                      ),
                                Text(widget.replyCheckDelete
                                      ? "!삭제된 댓글입니다!"
                                      : widget.reply!,
                                  style: GoogleFonts.jua(),
                                ),
                                Row(children: [
                                  Text(timecount(widget.replyTime), style: TextStyle(fontSize: 12.sp)),
                                  SizedBox(width: 160.w),
                                ])
                              ],
                            ),
                          )
                        ]))))
          ]));
        });
  }
}
