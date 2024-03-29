import 'package:dorandoran/common/basic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dorandoran/common/util.dart';
import '../component/logo.dart';
import '../component/next_button.dart';
import '../quest/namecheck.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  DateTime selectedDate = DateTime(2000,1,1);
  TextEditingController name = TextEditingController();
  Map<String, bool> namecheck = {'': false};
  String text = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Basic(
      widgets: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
          Logo(
              text: '첫 방문을\n환영합니다!',
              style: Theme.of(context).textTheme.headlineLarge!),
          Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                Text('닉네임을 설정해주세요', style:  Theme.of(context).textTheme.headlineMedium!),
                Row(
                  children: [
                    Container(
                      width: 220.w,
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
                    ),
                    SizedBox(width: 15.w),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            text = checkname(name.text.toString());
                          });
                          if (text == "") textchange(name.text.toString());
                        },
                        child: Text("확인", style: Theme.of(context).textTheme.labelSmall!,),
                        style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).brightness==Brightness.dark?Colors.black87:Colors.white,
                            side: BorderSide(color: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black87,
                            ))),
                  ],
                ),
                Text(
                  text,
                  style: text == '사용가능한 이름입니다.'
                      ? Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.blue)
                      : Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.red),
                ),
              ]),
              SizedBox(height: 12.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('생년월일을 선택해주세요', style:  Theme.of(context).textTheme.headlineMedium!),
                  SizedBox(height: 10.h),
                  Container(
                    width: 240.w,
                    height: 40.h,
                    child: TextButton(
                      child: Text(
                        '${selectedDate.year}-${getTimeFormat(selectedDate.month)}-${getTimeFormat(selectedDate.day)}',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 15.sp),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).brightness==Brightness.dark?Colors.black87:Colors.white,
                          side: BorderSide(color: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black87,)),
                      onPressed: dialog,
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
    );
  }

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

  void dialog() {
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
  }
}
