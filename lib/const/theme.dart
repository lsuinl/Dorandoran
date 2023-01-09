import 'package:flutter/material.dart';

final TextStyle whitestyle = TextStyle(
  color: Colors.white,
  fontSize: 17.0,
  fontWeight: FontWeight.w500,
);

Color backgroundcolor=Color(0xFF000054);

Decoration gradient= BoxDecoration(
borderRadius: BorderRadius.circular(80),
gradient: LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [Color(0xff3F0099),Color(0xFF000054)],
));
final url=Uri.parse(
  'http://124.60.219.83:8080/api/signup'
);

String getTimeFormat(int number) {
return number.toString().padLeft(2, '0');
}