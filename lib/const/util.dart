import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String? firebasetoken;
String? kakaotoken;
//폰트스타일
final TextStyle whitestyle = TextStyle(
  color: Colors.white,
  fontSize: 17.0,
  fontWeight: FontWeight.w500,
);

//배경색상
Color backgroundcolor=Color(0xFF000054);

//배경색상2(그라데이션)
Decoration gradient= BoxDecoration(
gradient: LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [Color(0xFF001954),Color(0xff3F2E99)],
));

//서버 url
final url=Uri.parse(
  'http://116.44.231.162:8080/api/signup'
);

//00 시간 설절
String getTimeFormat(int number) {
return number.toString().padLeft(2, '0');
}