import 'package:dorandoran/setting/setting_list/setting_list_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Top extends StatefulWidget {
  const Top({Key? key}) : super(key: key);

  @override
  State<Top> createState() => _TopState();
}

bool notice = true;
class _TopState extends State<Top> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              notice = !notice;
            });
          },
          icon: Icon(
            notice ? Icons.notifications : Icons.notifications_off,
            size: 30.0.r,
          ),
          padding: EdgeInsets.all(10.0),
        ),
        Text("도란도란", style: TextStyle(fontSize: 30.sp)),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: ()=>    Navigator.push(context, MaterialPageRoute(
              builder: (context) => SettingListScreen()),),
        )
      ],
    );
  }
}
