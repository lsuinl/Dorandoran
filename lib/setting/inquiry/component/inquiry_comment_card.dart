import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InquiryCommentCard extends StatelessWidget {
  final dynamic e;

  const InquiryCommentCard({
    required this.e,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("답변",style: TextStyle(fontSize: 20.sp)),
        Text(e['comment'],style: TextStyle(fontSize: 15.sp),),
        Text(e['commentCreateTime'],style: TextStyle(fontSize: 10.sp),)
      ],
    );
  }
}
