import 'dart:math';

import 'package:dorandoran/texting/home/quest/get_popular_hash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/uri.dart';
import 'component/home_tag_search.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({Key? key}) : super(key: key);

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetPopularHash(),
        builder: (context, snapshot) {
          List<String> populartagname = [];
          if (snapshot.hasData) {
            populartagname.addAll(snapshot.data!);
          }
          return ListView(children: [
            Column(children: [
              TagSearch(),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("인기 태그",
                      style: GoogleFonts.abel(
                          fontSize: 15.sp, fontWeight: FontWeight.w500))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: populartagname
                      .map((e) =>
                  Padding(padding: EdgeInsets.symmetric(vertical: 5.h),
                      child:
                      Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: Image.network('$urls/api/background/' +
                                          (Random().nextInt(99) + 1).toString())
                                      .image,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.white.withOpacity(0.6), BlendMode.dstATop)),

                            ),
                            child: Padding(
                                padding: EdgeInsets.all(13),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      fontSize: 20.sp, color: Colors.black),
                                )),
                          )))
                      .toList()),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 1.h,
                  color: Colors.grey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("나의 태그",
                      style: GoogleFonts.abel(
                          fontSize: 15.sp, fontWeight: FontWeight.w500))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Chip(
                    label: Text("태그1"),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Chip(
                    label: Text("태그2"),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Chip(
                    label: Text("태그3"),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("#태그1",
                      style: GoogleFonts.abel(
                          fontSize: 20.sp, fontWeight: FontWeight.w700)),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(">",
                      style: GoogleFonts.abel(
                          fontSize: 20.sp, fontWeight: FontWeight.w700)),
                ],
              ),
              SizedBox(height: 10.h),
              Container(
                color: Colors.green.shade100,
                height: 200.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("#태그2",
                      style: GoogleFonts.abel(
                          fontSize: 20.sp, fontWeight: FontWeight.w700)),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(">",
                      style: GoogleFonts.abel(
                          fontSize: 20.sp, fontWeight: FontWeight.w700)),
                ],
              ),
              SizedBox(height: 10.h),
              Container(
                color: Colors.green.shade100,
                height: 200.h,
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("#태그3",
                      style: GoogleFonts.abel(
                          fontSize: 20.sp, fontWeight: FontWeight.w700)),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(">",
                      style: GoogleFonts.abel(
                          fontSize: 20.sp, fontWeight: FontWeight.w700)),
                ],
              ),
              SizedBox(height: 10.h),
              Container(
                color: Colors.green.shade100,
                height: 200.h,
              ),
              SizedBox(height: 10.h),
            ])
          ]);
        });
  }
}
