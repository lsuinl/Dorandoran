import 'package:flutter/material.dart';
import 'package:dorandoran/common/css.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Basic extends StatefulWidget {
  final Widget widgets;

  const Basic({
    required this.widgets,
    Key? key}) : super(key: key);

  @override
  State<Basic> createState() => _BasicState();
}
DateTime? currentBackPressTime;
class _BasicState extends State<Basic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
                color: backgroundcolor,
                child: SafeArea(
                    top: true,
                    bottom: true,
                    child: widget.widgets
                )
            )
        );
  }
}
