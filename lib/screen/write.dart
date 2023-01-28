import 'package:flutter/material.dart';
import '../const/util.dart';


class Write extends StatefulWidget {
  const Write({Key? key}) : super(key: key);

  @override
  State<Write> createState() => _WriteState();
}


TextEditingController name = TextEditingController();
bool forme=false;

class _WriteState extends State<Write> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: gradient,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: whitestyle,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "닉네임을 입력해주세요",
                  hintStyle: whitestyle.copyWith(color: Colors.indigo),
                ),
                controller: name,
              ),
              TextButton(
                  onPressed: (){
                    setState(() {
                      forme = !forme;
                    });
                    print(forme);
                  },
                  child: Text("나만보기"),
              ),

            ],
          ),
        )
      ),
    );
  }
}
