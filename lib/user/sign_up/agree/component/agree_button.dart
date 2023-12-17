import 'package:dorandoran/user/sign_up/agree/component/agree_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../sign_up/screen/sign_up.dart';

class AgreeButton extends StatefulWidget {
  final TextStyle style;

  const AgreeButton({required this.style, Key? key}) : super(key: key);

  @override
  State<AgreeButton> createState() => _AgreeButtonState();
}

List<bool> agree = [false, false, false, false];

class _AgreeButtonState extends State<AgreeButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        allbutton(),
        SizedBox(height: 5.h),
        Container(
          height: 1.0.h,
          width: 450.0.w,
          color: Colors.black
        ),
        SizedBox(height: 8.h),
        checkbutton("이용약관에 동의합니다.", 1),
        checkbutton("개인정보 수집 및 이용에 동의합니다.", 2),
        checkbutton("위치기반 서비스 이용에 동의합니다.", 3),
        SizedBox(height: 20.h),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  elevation: 30,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.all(15)),
              onPressed: () {
                if (agree[0] == true)
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Text('다음', style: widget.style),
            ),
          ),
        ),
      ],
    );
  }

  Widget allbutton() {
    bool? isagree = false;
    isagree = agree[0];
    return Builder(builder: (context) {
      return Row(
        children: [
          Checkbox(
              value: isagree,
              onChanged: (value) {
                setState(() {
                  isagree = value;
                  for (int i = 0; i < agree.length; i++) agree[i] = value!;
                });
              }),
          Text("전체동의", style: Theme.of(context).textTheme.bodyMedium!,),
        ],
      );
    });
  }

  Widget checkbutton(String text, int index) {
    bool? isagree = false;
    isagree = agree[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: isagree,
                onChanged: (value) {
                  setState(() {
                    isagree = value;
                    agree[index] = value!;
                  });
                  if (!agree[0] && agree[1] && agree[2] && agree[3])
                    agree[0] = true;
                  if (value == false && agree[0])
                    agree[0] = false;
                }),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ],
        ),
        IconButton(
          alignment: Alignment.centerRight,
          icon: Icon(
              Icons.chevron_right,
              color: Colors.black87
          ),
          onPressed: (){
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  String texts="";
                  if(index==1) texts=one;
                  else if(index==2) texts=two;
                  else texts=three;
                  return AlertDialog(
                    content:  SingleChildScrollView(
                      child: Text(texts, style: Theme.of(context).textTheme.bodySmall!,)),
                    actions: [
                      TextButton(
                        child: Text('확인',
                            style:Theme.of(context).textTheme.bodyMedium!),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          },
        )
      ],
    );
  }
}
