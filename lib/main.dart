import 'dart:async';
import 'dart:io';
import 'package:dorandoran/common/basic.dart';
import 'package:dorandoran/firebase.dart';
import 'package:dorandoran/setting/notification/notification_list_screen.dart';
import 'package:dorandoran/texting/home/home.dart';
import 'package:dorandoran/user/login/screen/login_check.dart';
import 'package:dorandoran/user/sign_up/agree/using_agree.dart';
import 'package:dorandoran/user/sign_up/sign_up/screen/sign_up.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'common/storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'notice/notice_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
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
  print(firebasetoken);
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
class MyApp extends StatefulWidget {
  final ThemeMode themeMode;
  
  const MyApp ({
    required this.themeMode,
    super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    //Fluttertoast.showToast(msg: initialMessage?.data.toString() ??"d");
    if (initialMessage != null) {
      pushNotificationScreen();
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      pushNotificationScreen();
    });
  }
  @override
  void initState() {
    setupInteractedMessage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeProvider(initThemeMode: widget.themeMode)
        ),
      ],
        builder: (context, _) {
          return GetMaterialApp(
            initialBinding: BindingsBuilder.put(() => NotificationController(),
                permanent: true
            ),
            routes: <String, WidgetBuilder>{
              '/notification': (BuildContext context) => new NoticeScreen()
            },
            darkTheme: darkThemes,
            theme: whiteTheme,
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(),
                  child: child!)
              ;
            },
            home: const Home(),
          );
        });
  }
}

