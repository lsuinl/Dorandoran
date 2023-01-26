import 'package:flutter/material.dart';
import '../const/util.dart';


class Write extends StatelessWidget {
  const Write({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: gradient,
        child: Text("글쓰기",),
      ),
    );
  }
}
