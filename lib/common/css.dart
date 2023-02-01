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