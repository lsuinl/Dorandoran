import 'package:flutter/material.dart';
import 'package:dorandoran/common/css.dart';

class Basic extends StatelessWidget {
  final Widget widgets;

  const Basic({
    required this.widgets,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        decoration: gradient,
        child: SafeArea(
        top: false,
        bottom: true,
          child: widgets
    )
    )
    );
  }
}