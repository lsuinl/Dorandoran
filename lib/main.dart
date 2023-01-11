import 'package:dorandoran/screen/using_agree.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'd54cd76337470f87b093bfdadfa53292');
  runApp(
      MaterialApp(
        home: UsingAgree(),
      )
  );
}