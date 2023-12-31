import 'package:dorandoran/notice/notice_screen.dart';
import 'package:dorandoran/user/login/screen/login_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dorandoran/common/css.dart';
import '../main.dart';

class Basic extends StatefulWidget {
  final Widget widgets;

  const Basic({
    required this.widgets,
    super.key});

  @override
  State<Basic> createState() => _BasicState();
}

class _BasicState extends State<Basic> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.removeObserver(this);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      streamController.add('notification');
    });
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      // 앱이 표시되고 사용자 입력에 응답합니다.
      // 최초 앱 실행때는 해당 이벤트가 발생하지 않습니다.
        print("resumed");
        break;
      case AppLifecycleState.inactive:
      // 앱이 비활성화 상태이고 사용자의 입력을 받지 않습니다.
      // ios에서는 포 그라운드 비활성 상태에서 실행되는 앱 또는 Flutter 호스트 뷰에 해당합니다.
      // 안드로이드에서는 화면 분할 앱, 전화 통화, PIP 앱, 시스템 대화 상자 또는 다른 창과 같은 다른 활동이 집중되면 앱이이 상태로 전환됩니다.
      // inactive가 발생되고 얼마후 pasued가 발생합니다.
        print("inactive");
        break;
      case AppLifecycleState.paused:
      // 앱이 현재 사용자에게 보이지 않고, 사용자의 입력을 받지 않으며, 백그라운드에서 동작 중입니다.
      // 안드로이드의 onPause()와 동일합니다.
      // 응용 프로그램이 이 상태에 있으면 엔진은 Window.onBeginFrame 및 Window.onDrawFrame 콜백을 호출하지 않습니다.
        print("paused");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login_check()),
                (route) => false);
        break;
      case AppLifecycleState.detached:
      // 응용 프로그램은 여전히 flutter 엔진에서 호스팅되지만 "호스트 View"에서 분리됩니다.
      // 앱이 이 상태에 있으면 엔진이 "View"없이 실행됩니다.
      // 엔진이 처음 초기화 될 때 "View" 연결 진행 중이거나 네비게이터 팝으로 인해 "View"가 파괴 된 후 일 수 있습니다.
        print("detached");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login_check()),
                (route) => false);
        break;
    }
  }
  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color:Theme.of(context).brightness==Brightness.dark?Colors.black26:backgroundcolor,
            child: SafeArea(
                top: true,
                bottom: true,
                child: StreamBuilder<String>(
                    stream: streamController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == "notification") {
                          streamController.add("");
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const NoticeScreen();
                            }));
                          });
                        }
                      }
                      return widget.widgets;
                    })
            )
        )
    );
  }
}
