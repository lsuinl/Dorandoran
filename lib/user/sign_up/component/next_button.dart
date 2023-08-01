import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dorandoran/user/sign_up/quest/user.dart';
import 'package:dorandoran/common/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../texting/home/home.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 19.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              //side: BorderSide(width:3, color:Colors.brown),
              elevation: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.all(15)),
          onPressed: () async {
           if(namecheck[name.text]==true) { //닉네임체크넘어가야
            SharedPreferences prefs= await SharedPreferences.getInstance();
              await postUserRequest(
                  '${selectedDate.year}-${getTimeFormat(
                      selectedDate.month)}-${getTimeFormat(selectedDate.day)}',
                  name.text.toString(), prefs.getString("firebasetoken")!, prefs.getString("kakaotoken")!);
              print('${selectedDate.year}-${getTimeFormat(
                  selectedDate.month)}-${getTimeFormat(selectedDate.day)}');
              print('${name.text.toString()}');

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                new Home()));
           }
          },
          child: Text('다음', style:  Theme.of(context).textTheme.labelLarge!),
        ),
      ),
    );
  }
}
