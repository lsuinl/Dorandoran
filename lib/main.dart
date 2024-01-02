import 'dart:async';
import 'dart:io';
import 'package:dorandoran/firebase.dart';
import 'package:dorandoran/texting/home/home.dart';
import 'package:dorandoran/user/login/screen/kakao_login.dart';
import 'package:dorandoran/user/login/screen/login_check.dart';
import 'package:dorandoran/write/screen/write.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common/css.dart';
import 'common/theme_provider.dart';
import 'common/util.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'common/storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

StreamController<String> streamController = StreamController.broadcast();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //비동기 허용
  KakaoSdk.init(nativeAppKey: kakaonativekey); //카카오로그인
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Future.delayed(Duration(seconds: 1));
  String? firebasetoken = await FirebaseMessaging.instance.getToken(); //토큰 설정
  MobileAds.instance.initialize(); //광고
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); //회전방지
  final prefs = await SharedPreferences.getInstance(); //저장소 불러오기
  //테마모드
  ThemeMode themeMode = ThemeMode.light;
  final bool? isDark = prefs.getBool('DarkMode');
  if(isDark==true) themeMode=ThemeMode.dark;
  //파이어베이스설정
  prefs.setString('firebasetoken', firebasetoken??"");
  if (Platform.isAndroid) {
    prefs.setString("ostype", "Aos");
  } else if (Platform.isIOS) {
    prefs.setString("ostype", "Ios");
  }

    runApp(ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return MyApp(themeMode: themeMode);
        }));
  }

class MyApp extends StatelessWidget {
  final ThemeMode themeMode;

  const MyApp({
    required this.themeMode,
    super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeProvider(initThemeMode: themeMode)
        ),
      ],
        builder: (context, _) {
          return GetMaterialApp(
            initialBinding: BindingsBuilder.put(() => NotificationController(),
                permanent: true
            ),
            darkTheme: darkThemes,
            theme: whiteTheme,
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(),
                  child: child!)
              ;
            },
            home: const Login_check(),
          );
        });
  }
}
