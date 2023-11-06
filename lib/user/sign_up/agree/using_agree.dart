import 'package:dorandoran/common/basic.dart';
import 'package:dorandoran/user/sign_up/agree/component/agree_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../sign_up/component/logo.dart';

class UsingAgree extends StatelessWidget {

  UsingAgree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Basic(widgets: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Logo(text: '회원님,\n안녕하세요!', style: Theme.of(context).textTheme.headlineLarge!),
              AgreeButton(style: Theme.of(context).textTheme.labelLarge!),
            ],
          ),
        ),
      );
  }
}
