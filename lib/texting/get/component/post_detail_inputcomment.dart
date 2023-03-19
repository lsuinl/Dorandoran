import 'package:dorandoran/texting/get/quest/post_detail_postcomment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/css.dart';
import '../../../common/storage.dart';

class InputComment extends StatefulWidget {
  final int postId;
  final VoidCallback reset;

  const InputComment({
    required  this.postId,
    required this.reset,
    Key? key}) : super(key: key);

  @override
  State<InputComment> createState() => _InputCommentState();
}

TextEditingController controller =TextEditingController();
bool anonymity= true;

class _InputCommentState extends State<InputComment> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20), //모서리를 둥글게
          border: Border.all(color: Colors.black12, width: 3)), //테두리,
      width: 350.w,
      height: 50.h,
      child: Row(
        children: [
          IconButton(onPressed: checkanonymity, icon: anonymity? Icon(Icons.check_box_outlined,size: 24.r):Icon(Icons.check_box_outline_blank,size: 24.r)),
          Container(
              width: 264.w,
              child: TextFormField(
                controller: controller,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                  hintText: "댓글을 입력하세요.",
                  hintStyle: whitestyle.copyWith(color: Colors.black26,fontSize: 15.sp),
                ),
              )
          ),
          IconButton(onPressed: widget.reset, icon: Icon(Icons.send_and_archive_sharp,size: 24.r))
        ],
      ),);
  }
  checkanonymity(){
    setState(() {
      anonymity= !anonymity;
    });
  }

}
