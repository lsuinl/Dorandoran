import 'package:dorandoran/setting/main/setting_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../../notice/notice_screen.dart';

class Top extends StatefulWidget {
  final int number;
  const Top({
    required this.number,
    Key? key}) : super(key: key);

  @override
  State<Top> createState() => _TopState();
}

bool notice = true;

class _TopState extends State<Top> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(SolarIconsBold.settings,size: 30.r,color: Theme.of(context).brightness==Brightness.dark?Colors.white:const Color(0xFF1C274C),),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingListScreen())),
                ),
                Stack(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(SolarIconsBold.bell,size: 30.r,color:  Theme.of(context).brightness==Brightness.dark?Colors.white:const Color(0xFF1C274C),),
                      onPressed:() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NoticeScreen())),
                    ),
                   widget.number!=0? Container(
                      width: 35.w,
                      height: 30.h,
                      alignment: Alignment.topRight,
                      margin: const EdgeInsets.only(top: 5),
                      child: Container(
                        width: 15.w,
                        height: 17.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xffc32c37),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Center(
                            child: Text(
                              widget.number.toString(),
                              style: const TextStyle(fontSize: 10,color: Colors.white),
                          ),
                        ),
                      ),
                    ):Container()
                  ],
                )
              ],
            ))
      ],
    );
  }
}
