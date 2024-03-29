import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icons/solar_icons.dart';

import '../../common/util.dart';
import '../../user/sign_up/sign_up/quest/namecheck.dart';
import 'patch_change_nickname.dart';
import '../main/button_menu.dart';

class ChangeNicknameButton extends StatefulWidget {

  const ChangeNicknameButton({
    Key? key}) : super(key: key);

  @override
  State<ChangeNicknameButton> createState() => _ChangeNicknameButtonState();
}

class _ChangeNicknameButtonState extends State<ChangeNicknameButton> {

  @override
  Widget build(BuildContext context) {
    return MenuButton(
        icons: SolarIconsOutline.chandelier,
        text: "닉네임 변경",
        onPressed: () {
          TextEditingController name = TextEditingController();
          Map<String, bool> namecheck = {'': false};
          String text = "";
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (context, setState) {
                      void textchange(String name) {
                        postNameCheckRequest(name).then((value) {
                          if (value == 204) {
                            setState(() {
                              print(name);
                              text = '사용가능한 이름입니다.';
                              namecheck[name] = true;
                            });
                          } else if(value==409){
                            setState(() {
                              text = '이미 사용중인 이름입니다.';
                              namecheck[name] = false;
                            });
                          }
                          else if(value==422){
                            setState(() {
                              text = '부적절한 닉네임입니다.';
                              namecheck[name] = false;
                            });
                          }
                        });
                      }

                      return AlertDialog(
                      backgroundColor: Theme.of(context).brightness==Brightness.dark?Colors.black:Colors.white,
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
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black,)),
                                    hintText: "닉네임을 입력해주세요",
                                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.indigo),
                                  ),
                                  controller: name,
                                  maxLength: 9,
                                ),
                                width: 160.w,
                              ),
                             Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                              child:
                              TextButton(
                                child: Text("확인", style: Theme.of(context).textTheme.labelSmall!,),
                                style: TextButton.styleFrom(
                                    side: BorderSide(color: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black,)),
                                onPressed: () {
                setState(() {
                text = checkname(name.text.toString());
                });
                if (text == "") textchange(name.text.toString());
                                  }
                              )),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                      TextButton(
                      child: Text("취소", style: Theme.of(context).textTheme.labelSmall!,),
                      style: TextButton.styleFrom(
                      side: BorderSide(color: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black,)),
                      onPressed: () =>Navigator.of(context).pop()
                      ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                        child:
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
                      side: BorderSide(color: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black,)),
                            ))
                      ])
                      ]);
                });
              });
        });
  }
}
