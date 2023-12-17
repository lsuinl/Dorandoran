import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainLogo extends StatelessWidget {
  final String text;
  final TextStyle style;

  const MainLogo({required this.text, required this.style, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(height: 80),
      Image.asset(
        'asset/image/logo.png',
        width: 200.w,
        height: 200.h,
        alignment: Alignment.centerLeft,
      ),
    ]);
  }
}
