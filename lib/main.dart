import 'package:dorandoran/screen/kakao_login.dart';
import 'package:dorandoran/screen/using_agree.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  KakaoSdk.init(nativeAppKey: 'd54cd76337470f87b093bfdadfa53292');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MaterialApp(
        home: KaKaoLogin(),
      )
  );

}