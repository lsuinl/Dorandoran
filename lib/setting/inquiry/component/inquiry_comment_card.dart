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
        Text("답변",style: Theme.of(context).textTheme.bodyLarge!),
        Text(e['comment'],style: Theme.of(context).textTheme.bodyMedium!,),
        Text(e['commentCreateTime'],style: Theme.of(context).textTheme.bodySmall!)
      ],
    );
  }
}
