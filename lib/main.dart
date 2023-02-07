import 'package:dorandoran/texting/write/screen/write.dart';
import 'package:dorandoran/user/login/screen/kakao_login.dart';

import 'texting/get/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'common/storage.dart';

void main() async {
  KakaoSdk.init(nativeAppKey: kakaonativekey);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); //회전방지
  firebasetoken = await FirebaseMessaging.instance.getToken();
  runApp(ScreenUtilInit(
    designSize: Size(360,690),
    builder: (context,child){
      return MaterialApp(
        theme: ThemeData(fontFamily: GoogleFonts.ibmPlexSansKr().fontFamily),
        builder: (context, child) { //폰트크기고정
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!);
        },
        home: Write(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          Locale('ko',''),
          Locale('en',''),
        ],
      );
    },
  ));
}
