import 'dart:convert';
import 'package:dorandoran/screen/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dorandoran/const/theme.dart';
import 'package:http/http.dart' as http;

_postRequest(String dateOfBirth,String nickName, String identificationNumber) async {
  var response= await http.post(
    url,
    headers: <String, String> {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "dateOfBirth": dateOfBirth,
      "nickName": nickName,
      "identificationNumber":identificationNumber,
    }),
  );
  print(response.headers);
  print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    print("서버 통신양호");
  } else if (response.statusCode == 504) {
    print("서버와의 연결이 불안정 합니다.");
  } else {
    print("종목코드가 올바르지 않습니다.");
    throw Exception('Failed to contect Server.');
  }
}


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  DateTime selectedDate=DateTime.now();
  final TextStyle textStyle = TextStyle(
    color: Colors.white,
    fontSize: 17.0,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000054),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              children:[
                SizedBox(height: 200,),
                Image.asset('asset/image/logo.png',width: 100,height: 100,),
                SizedBox(height: 20,),
                Text('정보를 입력해주세요!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                //SizedBox(height: 142.0),
                SizedBox(height: 20,),
                TextField(
                  cursorColor: Colors.white,
                  style:textStyle
                ),
          IconButton(
            icon:Icon(Icons.abc),
              color: Colors.white,
              iconSize: 80.0,
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        height: 300.0,
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
                SizedBox(
                  //박스사이즈 늘리기 Container 또는 Row 가능,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          //side: BorderSide(width:3, color:Colors.brown),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          padding: EdgeInsets.all(15)
                      ),
                      onPressed: (){
                        _postRequest('2002-03-01','dkfjasl','suin');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Home()
                            ));
                      },
                      child: Text('다음',  style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                      ),
                      ),
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
