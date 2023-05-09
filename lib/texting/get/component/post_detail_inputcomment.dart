import 'package:dorandoran/texting/get/quest/post_detail_postcomment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/css.dart';
import '../../../common/storage.dart';
import '../screen/post_detail.dart';

class InputComment extends StatefulWidget {
  final int postId;
  final int commentId;
  final sendmessage;
  final reset;
  final bool? postcommentstate;

  const InputComment({required this.postId,required this.commentId,required this.sendmessage, required this.reset,required this.postcommentstate, Key? key})
      : super(key: key);

  @override
  State<InputComment> createState() => _InputCommentState();
}

TextEditingController controller = TextEditingController();
bool anonymity =true;
bool lockcheck=true;

class _InputCommentState extends State<InputComment> {
  @override
  void initState() {
      anonymity=widget.postcommentstate ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return
Container(
  color: Colors.transparent,
        child:
      Column(
        children: [
      widget.commentId!=0
          ? Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12, width: 3)), //테두리,
          width: 370.w,
          height: 40.h,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("대댓글 다는 중,,"),
                  IconButton(onPressed:(){
                    select=0;
                    widget.reset();
                  },
                    icon: Icon(Icons.close))
                    ],
                    )))
                        : SizedBox(height: 5.h),
                    Container(
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20), //모서리를 둥글게
                    border: Border.all(color: Colors.black12, width: 3)), //테두리,
                    width: 350.w,
                    height: 50.h,
                    child: Row(children: [
                    IconButton(
                    onPressed: (){
                      if(widget.postcommentstate!=null){
                        showDialog(
                            context: context,
                            barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                content: const Text("이미 작성한 댓글과 다른 상태로 댓글을 작성할 수 없습니다."),
                                actions: [
                                  TextButton(
                                    child: const Text('닫기',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () async {
                                      //안된다,
                                      //await deletereply(replyId,useremail);
                                     // deletedreply();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                      else {
                        checkanonymity();
                      }
                    },
                    icon: anonymity
                    ? Icon(Icons.
                  check_box_outlined, size: 24.r)
                    : Icon(Icons.check_box_outline_blank, size: 24.r)),
                      IconButton( //비밀댓글
                          onPressed: (){
                            setState(() {
                              lockcheck=!lockcheck;
                            });
                          },
                          icon:lockcheck? Icon(Icons.lock, size: 24.r):Icon(Icons.lock_open, size: 24.r)),
            Container(
                width: 220.w,
                child: TextFormField(
                  controller: controller,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    hintText: "댓글을 입력하세요.",
                    hintStyle: whitestyle.copyWith(
                        color: Colors.black26, fontSize: 15.sp),
                  ),
                )),
            IconButton( //메세지보내기;
                onPressed: (){
                  select=0;
                  widget.sendmessage();
    },
                  icon: Icon(Icons.
                send_and_archive_sharp, size: 24.r))
          ])),
    ]));
  }

  checkanonymity() {
    setState(() {
      anonymity = !anonymity;
    });
  }
}
