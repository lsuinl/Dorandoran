import 'package:flutter/material.dart';

//배경색상
Color backgroundcolor = const Color(0xFFF6F6F6);
//배경색상2(그라데이션)
Decoration gradient = const BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0x0fffffff), Color(0x0fffffff) ],
));