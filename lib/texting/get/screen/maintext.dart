import 'package:dorandoran/common/css.dart';
import 'package:flutter/material.dart';

class Main_Text extends StatelessWidget {
  const Main_Text({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: gradient,
        child: Text("카드입니다,..",style: TextStyle(color: Colors.black),),
      ),
    );
  }
}
