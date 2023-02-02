import 'package:dorandoran/common/storage.dart';
import 'package:dorandoran/texting/get/screen/home.dart';
import 'package:dorandoran/user/sign_up/component/logo.dart';
import 'package:dorandoran/user/sign_up/component/next_button.dart';
import 'package:dorandoran/user/sign_up/screen/using_agree.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dorandoran/common/css.dart';
import 'package:dorandoran/user/sign_up/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dorandoran/common/util.dart';

class SignUp extends StatefulWidget {

  const SignUp({ Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  DateTime selectedDate = DateTime.now();
  TextEditingController name = TextEditingController();
  Map<String,bool> namecheck={'':false};
  String text ="";


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: Container(
        decoration: gradient,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(children: [
              Logo(text: '첫 방문을\n환영합니다!', style: whitestyle),
              SizedBox(height: 50.h),
              Column(
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text('별명을 설정해주세요', style: whitestyle.copyWith(fontSize: 20.sp)),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Container(
                      child: TextField(
                        style: whitestyle,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: "닉네임을 입력해주세요",
                          hintStyle: whitestyle.copyWith(color: Colors.indigo),
                        ),
                        controller: name,
                        maxLength: 8,
                      ),
                      width: 220.w,
                    ),
                    SizedBox(width: 15.w),
                    TextButton(
                        onPressed: () {
                          checkname(name.text.toString());
                        },
                        child: Text("확인"),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            side: BorderSide(
                              color: Colors.white,
                            ))),
                  ],
                ),
                Text(text,style: text=='사용가능한 이름입니다.' ? whitestyle.copyWith(color: Colors.blue,fontSize: 14.sp):whitestyle.copyWith(color: Colors.red,fontSize: 14.sp),),
              ]),
                  SizedBox(height: 12.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('생년월일을 선택해주세요',
                          style: whitestyle.copyWith(fontSize: 20.sp)),
                      SizedBox(height: 10.h),
                      Container(
                        width: 240.w,
                        height: 40.h,
                        child: TextButton(
                          child: Text(
                            '${selectedDate.year}-${getTimeFormat(selectedDate.month)}-${getTimeFormat(selectedDate.day)}',
                            style: whitestyle.copyWith(fontSize: 15.sp),
                          ),
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              side: BorderSide(
                                color: Colors.white,
                              )),
                          onPressed: () {
                            showCupertinoDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    color: Color(0xDDFFFFFF), //색상,,
                                    height: 250.0.h,
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      initialDateTime: selectedDate,
                                      maximumYear: DateTime.now().year,
                                      maximumDate: DateTime.now(),
                                      onDateTimeChanged: (DateTime date) {
                                        setState(() {
                                          selectedDate = date; //사용자가 선택한 날짜 저장
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  NextButton(
                    selectedDate: selectedDate,
                    name: name,
                    namecheck: namecheck,
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
  void textchange(String context){
    setState((){
      text=context;
    });
  }

  void checkname(String name) {
    if (name == '') { //null상태
      textchange("닉네임을 입력해주세요.");
      print('null');
    }
    else if (name.length <= 1) {
      textchange("닉네임의 길이는 최소 2글자 이상이어야 합니다.");
    }
    else if (!RegExp(r"^[가-힣0-9a-zA-Z]*$").hasMatch(
        name)) { //제대로된 문자인지 확인.(특수문자.이모티콘 체크)
      textchange("올바르지 않은 닉네임입니다.");
    }
    else { //형식은 통과
      textchange("");
      postNameCheckRequest(name).then((value) {
        if (value == 200) {
          textchange('사용가능한 이름입니다.');
          namecheck[name] = true;
        }
        else {
          textchange('이미 사용중인 이름입니다.');
          namecheck[name] = false;
        }
      });
    }
  }
}