import 'package:dorandoran/common/basic.dart';
import 'package:flutter/material.dart';
import 'home/home.dart';

class loding extends StatefulWidget {
  const loding({Key? key}) : super(key: key);

  @override
  State<loding> createState() => _lodingState();
}

class _lodingState extends State<loding> {
  @override
  Widget build(BuildContext context) {
    loading();
    return Basic(widgets:Center(
              child: CircularProgressIndicator(),
            ),
        );
  }

  void loading() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => Home()), (route) => false);
  }
}
