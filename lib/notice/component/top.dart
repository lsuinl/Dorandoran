import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_icons/solar_icons.dart';

import '../../texting/home/home.dart';

class Top extends StatefulWidget {
  const Top({super.key});

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: ()=> Navigator.push(context,
            MaterialPageRoute(builder: (context) => Home())).then((value) => setState(() {})),
          icon: Icon(SolarIconsOutline.doubleAltArrowLeft,size: 30.r),
        ),
        Text("알림", style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w900)),
        Container(width: 35.w,)
      ],
    );
  }
}