import 'dart:async';

import 'package:dorandoran/notice/notice_screen.dart';
import 'package:dorandoran/user/login/screen/login_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dorandoran/common/css.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';

StreamController<String> streamController = StreamController.broadcast();
bool isnotice=false;
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
   // WidgetsBinding.instance.removeObserver(this);
  }
  //
  // @override
  // void dispose() {
  //   streamController.close();
  //   print("삭.제");
  //   super.dispose();
  // }

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
                        isnotice=true;
                        if (snapshot.data == "notification") {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushNamedAndRemoveUntil(context, '/notification', (route) => false);
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
