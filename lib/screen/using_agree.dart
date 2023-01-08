import 'package:dorandoran/screen/home.dart';
import 'package:dorandoran/screen/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:dorandoran/const/theme.dart';

class UsingAgree extends StatelessWidget {
  final TextStyle textStyle = whitestyle;

  UsingAgree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Logo(style: textStyle),
              //SizedBox(height: 142.0),
              AgreeButton(style: textStyle),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  final TextStyle style;

  const Logo({required this.style, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 200),
      Image.asset(
        'asset/image/logo.png',
        width: 100,
        height: 100,
      ),
      SizedBox(height: 20),
      Text('안녕하세요!',
          style: style.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w800,
          )),
    ]);
  }
}

class AgreeButton extends StatefulWidget {
  final TextStyle style;

  const AgreeButton({required this.style, Key? key}) : super(key: key);

  @override
  State<AgreeButton> createState() => _AgreeButtonState();
}

List<bool?> agree = [false, false, false, false];

class _AgreeButtonState extends State<AgreeButton> {
  Widget checkbutton(String text, int index) {
    bool? isagree = false;
    isagree = agree[index];
    return Builder(builder: (context) {
      return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          checkboxShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            text,
            style: widget.style,
          ),
          value: isagree,
          onChanged: (value) {
            showDialog(
                context: context,
                barrierDismissible: false, // 바깥 영역 터치시 닫을지 여부
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.black,
                    content: const Text("..."),
                    actions: [
                      TextButton(
                        child: const Text('동의',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                        onPressed: () {
                          isagree = true;
                          setState(() {
                            value = isagree;
                            agree[index] = true;
                            if (index == 0) {
                              for (var Agree in agree) {
                                Agree = true;
                              }
                            }
                            if (agree[1] == true &&
                                agree[2] == true &&
                                agree[3] == true &&
                                agree[0] == false) //모두동의
                              agree[0] = true;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        checkbutton("전체동의", 0),
        SizedBox(height: 5),
        Container(
          height: 1.0,
          width: 450.0,
          color: Colors.white,
        ),
        SizedBox(height: 8),
        checkbutton("이용약관에 동의합니다.", 1),
        checkbutton("개인정보 수집 및 이용에 동의합니다.", 2),
        checkbutton("위치기반 서비스 이용에 동의합니다.", 3),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  //side: BorderSide(width:3, color:Colors.brown),
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.all(15)),
              onPressed: () {
                if (agree[0] == true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                }
              },
              child: Text('다음', style: widget.style),
            ),
          ),
        ),
      ],
    );
  }
}
