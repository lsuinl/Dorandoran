import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icons/solar_icons.dart';

import '../../common/util.dart';
import '../../user/sign_up/sign_up/quest/namecheck.dart';
import '../quest/patch_change_nickname.dart';
import 'button_menu.dart';

class ChangeNicknameButton extends StatefulWidget {

  const ChangeNicknameButton({
    Key? key}) : super(key: key);

  @override
  State<ChangeNicknameButton> createState() => _ChangeNicknameButtonState();
}

class _ChangeNicknameButtonState extends State<ChangeNicknameButton> {
  TextEditingController name = TextEditingController();
  Map<String, bool> namecheck = {'': false};
  String text = "";

  @override
  Widget build(BuildContext context) {
   print(text);
    return MenuButton(
        icons: SolarIconsOutline.chandelier,
        text: "닉네임 변경",
        onPressed: () {
          setState(() {
            name.text = "";
            text = "";
          });
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                      backgroundColor: Colors.white,
                      content: Text('닉네임을 설정해주세요', style: Theme.of(context).textTheme.headlineMedium!),
                      actions: [
                        Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: TextField(
                                  style: Theme.of(context).textTheme.bodyMedium!,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                                    hintText: "닉네임을 입력해주세요",
                                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.indigo),
                                  ),
                                  controller: name,
                                  maxLength: 9,
                                ),
                                width: 180.w,
                              ),
                              SizedBox(width: 15.w),
                              TextButton(
                                child: Text("확인", style: Theme.of(context).textTheme.labelSmall!,),
                                style: TextButton.styleFrom(
                                    primary: Colors.black54,
                                    side: BorderSide(color: Colors.black54)),
                                onPressed: () {
                                  //textchange 네임체크 api 요청 후 메세지
                                  //checkname 이름 형식 체크
                                  if(name.text==""){
                                    setState(() {
                                      text="닉네임을 입력해주세요.";
                                    });
                                  }
                                  else{
                                    setState(() {
                                      text = checkname(name.text);
                                    });
                                    if(text=="")
                                      postNameCheckRequest(name.text).then((value) {
                                        if (value == 200) {
                                          setState(() {
                                            text = '사용가능한 이름입니다.';
                                            namecheck[name.text] = true;
                                          });
                                        } else {
                                          setState(() {
                                            text = '이미 사용중인 이름입니다.';
                                            namecheck[name.text] = false;
                                          });
                                        }
                                      });
                                  }
                                },
                              ),
                            ],
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(text,
                                      style: text == '사용가능한 이름입니다.'
                                          ? Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.blue)
                                          : Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.red)))),
                        ]),
                        TextButton(
                            onPressed: () {
                              if (namecheck[name.text] == true) {
                                PatchChangeNickname(name.text);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              "변경하기",
                              style: Theme.of(context).textTheme.labelSmall!,
                            ),
                            style: TextButton.styleFrom(
                                primary: Colors.black54,
                                side: BorderSide(
                                  color: Colors.black54,
                                ))),
                      ]);
                });
              });
        });
  }
}
