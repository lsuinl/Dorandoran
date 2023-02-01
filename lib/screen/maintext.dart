import 'package:dorandoran/const/css.dart';
import 'package:flutter/material.dart';

class Card_inside extends StatelessWidget {
  const Card_inside({Key? key}) : super(key: key);

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
