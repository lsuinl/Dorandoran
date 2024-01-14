import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_icons/solar_icons.dart';

import '../../texting/home/home.dart';

class Top extends StatefulWidget {
  const Top({Key? key}) : super(key: key);

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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Image.asset(
                Theme.of(context).brightness==Brightness.dark? 'asset/image/white_logo.png': 'asset/image/logo.png',
                width: 35.w,
                height: 40.h,
                alignment: Alignment.centerLeft,
              ),
              Text(" doran",
                  style: GoogleFonts.roboto(
                      fontSize: 24.sp, fontWeight: FontWeight.w800)),
            ],
          ),
        )
      ],
    );
  }
}
