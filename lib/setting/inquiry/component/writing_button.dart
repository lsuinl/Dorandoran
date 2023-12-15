import 'package:dorandoran/setting/inquiry/writing_inquiry_screen.dart';
import 'package:flutter/material.dart';

//글쓰기 버튼
class WritingButton extends StatelessWidget {
  const WritingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomRight,
        child:
        Padding(
            padding: EdgeInsets.all(20),
            child: RawMaterialButton(
              onPressed: () =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          WritingInquiryScreen())),
              elevation: 5.0,
              fillColor: Theme.of(context).brightness==Brightness.dark?Colors.black26:Colors.blue[300],
              child: Icon(
                Icons.edit,
                size: 50.0,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            )
        )
    );
  }
}