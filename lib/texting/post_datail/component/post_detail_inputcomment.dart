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
                  decoration: BoxDecoration(//테두리,
                      color: Theme.of(context).brightness==Brightness.dark?Colors.black26:const Color(0xFFBDBDBD),
                      border: Border.all(color: Colors.black12, width: 3)),
                  width: 370.w,
                  height: 40.h,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("대댓글 다는 중,,"),
                          IconButton(
                              onPressed: () {
                                select = 0;
                                widget.reset();
                              },
                              icon: const Icon(Icons.close))
                        ],
                      )))
              : SizedBox(height: 5.h),
          Container(
              decoration: BoxDecoration(color: Theme.of(context).brightness==Brightness.dark?Colors.black26: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(20)), //모서리를 둥글게 테두리,
              width: 320.w,
              height: 35.h,
              child: Row(children: [
                IconButton(
                    padding: const EdgeInsets.only(left: 8,right: 5),
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      if (widget.postcommentstate!=null) {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Theme.of(context).brightness==Brightness.dark?Colors.grey[600]:Colors.white24,
                                content: const Text("이미 작성한 댓글과 다른 상태로 \n댓글을 작성할 수 없습니다."),
                                actions: [
                                  TextButton(
                                    child: Text('닫기',
                                        style: TextStyle(color: Theme.of(context).brightness==Brightness.dark?Colors.white:const Color(0xFF1C274C), fontSize: 16, fontWeight: FontWeight.w700)),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                ],
                              );
                            });
                      } else {
                        checkanonymity();
                        if (anonymity == true) {
                          Fluttertoast.showToast(msg: "익명으로 설정되었습니다.");
                        } else {
                          Fluttertoast.showToast(msg: "익명이 해제되었습니다.");
                        }
                      }
                    },
                    icon: anonymity
                        ? Icon(SolarIconsOutline.checkSquare, size: 24.r)
                        : Icon(SolarIconsOutline.closeSquare, size: 24.r)),
                IconButton(
                  //비밀댓글
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        lockcheck = !lockcheck;
                        if(lockcheck==true) {
                          Fluttertoast.showToast(msg: "비밀글로 설정되었습니다.");
                        } else {
                          Fluttertoast.showToast(msg: "비밀글이 해제되었습니다.");
                        }
                      });
                    },
                    icon: lockcheck
                        ? Icon(Icons.lock, size: 20.r)
                        : Icon(Icons.lock_open, size: 20.r)),
                const SizedBox(width: 5),
                Flexible(
                    child: TextFormField(
                  controller: controller,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                    hintText: "댓글을 입력하세요.",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!,
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
