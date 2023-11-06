import 'package:dorandoran/notice/notice_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dorandoran/common/css.dart';

import '../main.dart';
import '../setting/notification/notification_list_screen.dart';

class Basic extends StatefulWidget {
  final Widget widgets;

  const Basic({
    required this.widgets,
    super.key});

  @override
  State<Basic> createState() => _BasicState();
}

class _BasicState extends State<Basic> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      streamController.add('notification');
    });
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
            color: backgroundcolor,
            child: SafeArea(
                top: true,
                bottom: true,
                child: StreamBuilder<String>(
                    stream: streamController.stream,
                    builder: (context, snapshot) {
                      print("실행은됨");
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
