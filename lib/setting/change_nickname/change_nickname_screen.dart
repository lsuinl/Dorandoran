import 'package:dorandoran/common/basic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/util.dart';
import '../../user/sign_up/quest/namecheck.dart';
import 'quest/patch_change_nickname.dart';

class ChangeNicknameScreen extends StatefulWidget {
  const ChangeNicknameScreen({Key? key}) : super(key: key);

  @override
  State<ChangeNicknameScreen> createState() => _ChangeNicknameScreenState();
}

class _ChangeNicknameScreenState extends State<ChangeNicknameScreen> {
  TextEditingController name = TextEditingController();
  Map<String, bool> namecheck = {'': false};
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Basic(
        widgets: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
      Text('닉네임을 설정해주세요', style:  Theme.of(context).textTheme.headlineMedium!),
      Column(
        children:[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: TextField(
              style: Theme.of(context).textTheme.bodyMedium!,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54)),
                hintText: "닉네임을 입력해주세요",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.indigo),
              ),
              controller: name,
              maxLength: 9,
            ),
            width: 220.w,
          ),
          SizedBox(width: 15.w),
          TextButton(
              onPressed: () {
                //   textchange(checkname(name.text.toString()),name.text.toString())
                setState(() {
                  text = checkname(name.text.toString());
                });
                if (text == "") textchange(name.text.toString());
              },
              child: Text("확인", style: Theme.of(context)
                  .textTheme
                  .labelSmall!,),
              style: TextButton.styleFrom(
                  primary: Colors.black54,
                  side: BorderSide(
                    color: Colors.black54,
                  ))),
        ],
      ),
      Text(
        text,
        style: text == '사용가능한 이름입니다.'
            ? Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.blue)
            : Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.red),
      ),  ]),
            TextButton(
                onPressed: () {
                  if(namecheck[name.text]==true) {
                    PatchChangeNickname(name.text);
                    Navigator.pop(context);
                  }
                },
                child: Text("변경하기", style: Theme.of(context)
                    .textTheme
                    .labelSmall!,),
                style: TextButton.styleFrom(
                    primary: Colors.black54,
                    side: BorderSide(
                      color: Colors.black54,
                    ))),
    ]));
  }

  void textchange(String name) {
    postNameCheckRequest(name).then((value) {
      if (value == 200) {
        setState(() {
          print(name);
          text = '사용가능한 이름입니다.';
          namecheck[name] = true;
        });
      } else {
        setState(() {
          text = '이미 사용중인 이름입니다.';
          namecheck[name] = false;
        });
      }
    });
  }

}
