import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solar_icons/solar_icons.dart';
import '../post_detail.dart';

class InputComment extends StatefulWidget {
  final int postId;
  final int commentId;
  final sendmessage;
  final reset;
  final bool? postcommentstate;

  const InputComment(
      {required this.postId,
      required this.commentId,
      required this.sendmessage,
      required this.reset,
      required this.postcommentstate,
      Key? key})
      : super(key: key);

  @override
  State<InputComment> createState() => _InputCommentState();
}

TextEditingController controller = TextEditingController();
bool anonymity = true;
bool lockcheck = true;

class _InputCommentState extends State<InputComment> {
  @override
  void initState() {
    anonymity = widget.postcommentstate ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Column(children: [
          widget.commentId != 0
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12, width: 3)),
                  //테두리,
                  width: 370.w,
                  height: 40.h,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("대댓글 다는 중,,"),
                          IconButton(
                              onPressed: () {
                                select = 0;
                                widget.reset();
                              },
                              icon: Icon(Icons.close))
                        ],
                      )))
              : SizedBox(height: 5.h),
          Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(20), //모서리를 둥글게
              ), //테두리,
              width: 320.w,
              height: 35.h,
              child: Row(children: [
                IconButton(
                   // constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (widget.postcommentstate != null) {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            // 바깥 영역 터치시 닫을지 여부
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                content: const Text(
                                    "이미 작성한 댓글과 다른 상태로 댓글을 작성할 수 없습니다."),
                                actions: [
                                  TextButton(
                                    child: const Text('닫기',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700)),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      } else {
                        checkanonymity();
                      }
                    },
                    icon: anonymity
                        ? Icon(SolarIconsOutline.checkSquare, size: 24.r)
                        : Icon(SolarIconsBroken.checkSquare, size: 24.r)),
                IconButton(
                  //비밀댓글
                    constraints: BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        lockcheck = !lockcheck;
                      });
                    },
                    icon: lockcheck
                        ? Icon(Icons.lock, size: 20.r)
                        : Icon(Icons.lock_open, size: 20.r)),
                SizedBox(width: 5),
                Flexible(
                    child: TextFormField(
                  controller: controller,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    hintText: "댓글을 입력하세요.",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.black26, fontSize: 15.sp),
                  ),
                )),
                IconButton(
                    //메세지보내기;
                    onPressed: () {
                      if (controller.text != "") {
                        select = 0;
                        widget.sendmessage();
                        controller.clear();
                      }
                    },
                    icon: Icon(SolarIconsOutline.plain3, size: 24.r))
              ])),
        ]));
  }

  checkanonymity() {
    setState(() {
      anonymity = !anonymity;
    });
  }
}
