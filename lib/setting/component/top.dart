import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Image.asset(
                'asset/image/mini_logo.png',
                width: 35.w,
                height: 40.h,
                alignment: Alignment.centerLeft,
              ),
              Text(" doran",
                  style: GoogleFonts.roboto(
                      fontSize: 24.sp, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
       Container()
      ],
    );
  }
}
