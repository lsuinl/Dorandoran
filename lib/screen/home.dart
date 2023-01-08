import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.indigoAccent,
      body: Center(
      child: Text(
      'Hello World',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
    ),
    ),
    );
  }
}
