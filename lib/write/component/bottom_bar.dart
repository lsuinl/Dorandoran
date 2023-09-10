import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_icons/solar_icons.dart';

class BottomBar extends StatefulWidget {
  final VoidCallback formefun;
  final VoidCallback usinglocationfun;
  final VoidCallback Showbackgroundimgnamefun;
  final VoidCallback annoyfun;
  final bool forme;
  final bool usinglocation;
  final bool anony;

  const BottomBar({
    required this.formefun,
    required this.usinglocationfun,
    required this.Showbackgroundimgnamefun,
    required this.annoyfun,
    required this.forme,
    required this.usinglocation,
    required this.anony,
    Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  TextStyle buttontext = GoogleFonts.gowunBatang(fontSize: 12.sp);

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  IconButton(
                      icon: widget.forme
                          ? Icon(SolarIconsBold.lockKeyhole, size: 25.r,)
                          : Icon(SolarIconsBold.lockKeyholeUnlocked, size: 25.r),
                      onPressed: widget.formefun
                  ),
                  Text("나만보기", style: buttontext)
                ]),
                Column(children: [
                  IconButton(
                      icon: widget.usinglocation
                          ? Icon(SolarIconsBold.mapPoint, size: 25.r)
                          : Icon(SolarIconsOutline.mapPoint, size: 25.r),
                      onPressed: widget.usinglocationfun
                  ),
                  Text("위치정보", style: buttontext)
                ]),
                Column(children: [
                  IconButton(
                      icon: Icon(SolarIconsBold.galleryEdit, size: 25.r),
                      onPressed: widget.Showbackgroundimgnamefun
                  ),
                  Text("배경", style: buttontext)
                ]),
                Column(children: [
                  IconButton(
                      icon: widget.anony
                          ? Icon(Icons.person, size: 25.r,)
                          : Icon(Icons.person_off, size: 25.r),
                      onPressed: widget.annoyfun
                  ),
                  Text("익명", style: buttontext)
                ]),
              ],
            );
  }
}
