import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dorandoran/common/util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../texting/home/home.dart';
import '../quest/user.dart';


class NextButton extends StatelessWidget {
  final DateTime selectedDate;
  final TextEditingController name;
  final Map<String,bool> namecheck;

  const NextButton(
      {
        required this.namecheck,
        required this.selectedDate,
        required this.name,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              elevation: 30,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.all(15)),
          onPressed: () async {
            if(namecheck[name.text]==null){
              Fluttertoast.showToast(msg: "닉네임 중복 확인이 필요합니다.");
            }
            else if(namecheck[name.text]==false){
              Fluttertoast.showToast(msg: "닉네임을 입력하세요");
            }
            else if (namecheck[name.text] == true) {//닉네임체크넘어가야
              await postUserRequest('${selectedDate.year}-${getTimeFormat(selectedDate.month)}-${getTimeFormat(selectedDate.day)}', name.text.toString());
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => new Home()));
            }
          },
          child: Text('다음', style:  Theme.of(context).textTheme.labelLarge!),
        ),
      ),
    );
  }
}
