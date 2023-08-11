import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:dorandoran/common/basic.dart';
import 'package:dorandoran/firebase.dart';
import 'package:dorandoran/texting/home/home.dart';
import 'package:dorandoran/texting/home/tag_screen.dart';
import 'package:dorandoran/texting/post_datail/post_detail.dart';
import 'package:dorandoran/texting/write/screen/write.dart';
import 'package:dorandoran/user/login/screen/kakao_login.dart';
import 'package:dorandoran/user/login/screen/login_check.dart';
import 'package:dorandoran/user/sign_up/screen/sign_up.dart';
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
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  KakaoSdk.init(nativeAppKey: kakaonativekey);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); //회전방지
  String firebasetoken = (await FirebaseMessaging.instance.getToken())!;
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
              child: child!
          );
        },
        home: NativeExample(),
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

/// A simple app that loads a native ad.
class NativeExample extends StatefulWidget {
  const NativeExample({super.key});

  @override
  NativeExampleState createState() => NativeExampleState();
}

class NativeExampleState extends State<NativeExample> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;
  // final double _adAspectRatioSmall = (91 / 355);
  final double _adAspectRatioMedium = (91 / 355);

  final String _adUnitId = 'ca-app-pub-2389438989674944/9821322845';

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Column(
                children: [
                      if (_nativeAdIsLoaded && _nativeAd != null)
                        SizedBox(
                            height: MediaQuery.of(context).size.width *
                                _adAspectRatioMedium,
                            width: MediaQuery.of(context).size.width,
                            child: AdWidget(ad: _nativeAd!)),
                ],
              ),
            ));
  }

  void _loadAd() {
    setState(() {
      _nativeAdIsLoaded = false;
    });
    _nativeAd = NativeAd(
        adUnitId: _adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _nativeAdIsLoaded = true;
            });
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(
            templateType: TemplateType.small,
        ))
      ..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }
}
