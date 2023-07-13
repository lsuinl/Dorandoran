import 'package:dorandoran/firebase.dart';
import 'package:dorandoran/texting/home/home.dart';
import 'package:dorandoran/user/login/screen/login_check.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String firebasetoken = (await FirebaseMessaging.instance.getToken())!;
  print(firebasetoken);
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('firebasetoken', firebasetoken!);
  runApp(ScreenUtilInit(
    designSize: Size(360, 690),
    builder: (context, child) {
      //실행(with 폰트)
      return GetMaterialApp(
        initialBinding: BindingsBuilder.put(()=> NotificationController(),permanent: true),
        theme: ThemeData(
          fontFamily: GoogleFonts.ibmPlexSansKr().fontFamily,
          textTheme: TextTheme(
            headlineLarge: TextStyle( //큰 제목
              color: Colors.black87,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
            headlineMedium: TextStyle( //중간크기 안내문구
            color: Colors.black87,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
            bodyMedium: TextStyle( //기본 텍스트
                color: Colors.black87,
                fontSize: 13.sp
            ),
            bodySmall: TextStyle( //데이터 로딩중..
                color: Colors.black26,
                fontSize: 10.sp
            ),
            labelLarge: TextStyle( //버튼 텍스트 큰거
                color: Colors.black87,
                fontSize: 18.sp
            ),
            labelMedium:  GoogleFonts.gowunBatang( //버튼 텍스트 내부 글쓰기관련 버튼같ㅇ느거
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w300,
            ),
            labelSmall: TextStyle( //버튼 작은 텍스트(확인 등)
                color: Colors.black87,
                fontSize: 14.sp
            ),
          ),
          primarySwatch: Colors.blue,
          canvasColor: Colors.transparent,
        ),
        builder: (context, child) {
          //폰트크기고정
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!);
        },
        home: Login_check(),
        //번영(영어.한국어)
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          Locale('ko', ''),
          Locale('en', ''),
        ],
      );
    },
  ));
}
