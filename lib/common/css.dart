import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

//폰트스타일
final TextStyle whitestyle = TextStyle(
  color: Colors.black87,
  fontSize: 17.sp,
  fontWeight: FontWeight.w500,
);

final TextStyle buttontextstyle=GoogleFonts.gowunBatang(
      color: Colors.white,
      fontSize: 14.sp,
      fontWeight: FontWeight.w300,
);
//배경색상
Color backgroundcolor = Color(0xFFF6F6F6);

//배경색상2(그라데이션)
Decoration gradient = BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFF6F6F6), Color(0xFFF6F6F6) ],
));