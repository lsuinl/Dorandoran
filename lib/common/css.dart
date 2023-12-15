import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//배경색상
Color backgroundcolor = Color(0xFFF6F6F6);
//배경색상2(그라데이션)
Decoration gradient = BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFFFF), Color(0xFFFFFFF) ],
));