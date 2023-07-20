import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class BottomBar extends StatefulWidget {
  final VoidCallback formefun;
  final VoidCallback usinglocationfun;
  final VoidCallback dummyFillefun;
  final VoidCallback Showbackgroundimgnamefun;
  final VoidCallback ShowHashTagfun;
  final VoidCallback annoyfun;
  final bool forme;
  final bool usinglocation;
  final bool anony;

  const BottomBar({
    required this.formefun,
    required this.usinglocationfun,
    required this.dummyFillefun,
    required this.Showbackgroundimgnamefun,
    required this.ShowHashTagfun,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  IconButton(
                      icon: widget.forme
                          ? Icon(Icons.lock, size: 25.r,)
                          : Icon(Icons.lock_open, size: 25.r),
                      onPressed: widget.formefun
                  ),
                  Text("나만보기", style: buttontext)
                ]),
                Column(children: [
                  IconButton(
                      icon: widget.usinglocation
                          ? Icon(Icons.location_on, size: 25.r)
                          : Icon(Icons.location_off_outlined, size: 25.r),
                      onPressed: widget.usinglocationfun
                  ),
                  Text("위치정보", style: buttontext)
                ]),
                Column(children: [
                  IconButton(
                      icon: Icon(Icons.image, size: 25.r),
                      onPressed: widget.dummyFillefun
                  ),
                  Text("갤러리", style: buttontext)
                ]),

                Column(children: [
                  IconButton(
                      icon: Icon(Icons.grid_view, size: 25.r),
                      onPressed: widget.Showbackgroundimgnamefun
                  ),
                  Text("감성배경", style: buttontext)
                ]),
                Column(children: [
                  IconButton(
                      icon: Icon(Icons.tag, size: 25.r),
                      onPressed: widget.ShowHashTagfun
                  ),
                  Text("해시태그", style: buttontext,)
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
