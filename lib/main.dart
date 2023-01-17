import 'package:dorandoran/screen/kakao_login.dart';
import 'package:dorandoran/screen/using_agree.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'const/util.dart';
void main() async{

  KakaoSdk.init(nativeAppKey: 'd54cd76337470f87b093bfdadfa53292');
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  firebasetoken=await FirebaseMessaging.instance.getToken();
  runApp(
      MaterialApp(
        home: KaKaoLogin(),
      )
  );
}