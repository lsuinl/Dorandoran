import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

//배경색상
Color backgroundcolor = const Color(0xFFF6F6F6);
//배경색상2(그라데이션)
Decoration gradient = const BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0x0fffffff), Color(0x0fffffff) ],
));

ThemeData darkThemes = ThemeData(
brightness: Brightness.dark,
fontFamily: GoogleFonts.ibmPlexSansKr().fontFamily,
textTheme: TextTheme(
headlineLarge: TextStyle(
//큰 제목
color: Colors.white,
fontSize: 24.sp,
fontWeight: FontWeight.w700,
),
headlineMedium: TextStyle(
//중간크기 안내문구
color: Colors.white,
fontSize: 18.sp,
fontWeight: FontWeight.w500,
),
bodyMedium: TextStyle(
//기본 텍스트
color: Colors.white,
fontSize: 13.sp),
bodySmall: TextStyle(
//데이터 로딩중..
color: Colors.white,
fontSize: 12.sp),
labelLarge: TextStyle(
//버튼 텍스트 큰거
color: Colors.white,
fontSize: 18.sp),
labelMedium: GoogleFonts.gowunBatang(
//버튼 텍스트 내부 글쓰기관련 버튼같ㅇ느거
color: Colors.white,
fontSize: 16.sp,
fontWeight: FontWeight.w300,
),
labelSmall: TextStyle(
//버튼 작은 텍스트(확인 등)
color: Colors.white,
fontSize: 14.sp),
));

ThemeData whiteTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: GoogleFonts.ibmPlexSansKr().fontFamily,
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      //큰 제목
      color: Colors.black87,
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      //중간크기 안내문구
      color: Colors.black87,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      //기본 텍스트
        color: Colors.black87,
        fontSize: 15.sp),
    bodySmall: TextStyle(
      //데이터 로딩중..
        color: Colors.black26,
        fontSize: 12.sp),
    labelLarge: TextStyle(
      //버튼 텍스트 큰거
        color: Colors.black87,
        fontSize: 18.sp),
    labelMedium: GoogleFonts.gowunBatang(
      //버튼 텍스트 내부 글쓰기관련 버튼같ㅇ느거
      color: Colors.white,
      fontSize: 16.sp,
      fontWeight: FontWeight.w300,
    ),
    labelSmall: TextStyle(
      //버튼 작은 텍스트(확인 등)
        color: Colors.black87,
        fontSize: 14.sp),
  ),
  primarySwatch: Colors.blue,
  canvasColor: Colors.transparent,
);