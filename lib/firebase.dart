import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'main.dart';
class NotificationController extends GetxController {
  // 메시징 서비스 기본 객체 생성
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void onInit() async{
    /// 첫 빌드시, 권한 확인하기 아이폰은 무조건
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    _getToken();
    _onMessage();
    super.onInit();
  }

  /// 디바이스 고유 토큰
  void _getToken() async{
    String? token= await messaging.getToken();
    try{
      print(token);
    } catch(e) {}
  }

  /// * 안드로이드에서 foreground 알림 위한 flutter_local_notification 라이브러리 *
  /// 1. channel 생성 (우리의 알림을 따로 전달해줄 채널을 직접 만든다)
  /// 2. 그 채널을 우리 메인 채널로 정해줄 플러그인을 만들어준다.
  // 1.
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  // 2.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void _onMessage() async{
    /// * local_notification 관련한 플러그인 활용 *
    /// 1. 위에서 생성한 channel 을 플러그인 통해 메인 채널로 설정한다.
    /// 2. 플러그인을 초기화하여 추가 설정을 해준다.
    // 1.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    // 2.
    await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'), iOS: DarwinInitializationSettings()),
    );
    /// * onMessage 설정
    // 1. 콘솔에서 발송하는 메시지를 message 파라미터로 받아온다.
    /// 메시지가 올 때마다 listen 내부 콜백이 실행된다.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // android 일 때만 flutterLocalNotification 을 대신 보여주는 거임. 그래서 아래와 같은 조건문 설정.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description
            ),
          ),
        );
      }
      print('foreground 상황에서 메시지를 받았다.');
      print('Message data: ${message.data}');// 데이터 유무 확인
      if (message.notification != null) { // notification 유무 확인
        print('Message also contained a notification: ${message.notification!.body}');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("우효: $message");
    });
  }
}