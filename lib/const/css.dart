import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//폰트스타일
final TextStyle whitestyle = TextStyle(
  color: Colors.white,
  fontSize: 17.sp,
  fontWeight: FontWeight.w500,
);

//배경색상
Color backgroundcolor = Color(0xFF000054);

//배경색상2(그라데이션)
Decoration gradient = BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFFFFF),Color(0xFFFFFFFF) ],
));

//00 시간 설절
String getTimeFormat(int number) {
  return number.toString().padLeft(2, '0');
}

// 20개씩 데이터줄것임.
// 글 하나 당 json받아서 쓰기
//사용자지정사지 ㄴmultpartfile