import 'dart:io';
import 'dart:math';
import 'package:dorandoran/common/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dorandoran/common/uri.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../common/basic.dart';
import '../component/bottom_bar.dart';
import '../component/post_button.dart';
import '../component/write_middlefield.dart';
import 'package:google_fonts/google_fonts.dart';

class Write extends StatefulWidget {
  const Write({Key? key}) : super(key: key);

  @override
  State<Write> createState() => _WriteState();
}

TextEditingController contextcontroller = TextEditingController();
bool forme = false;
bool usinglocation = false;
bool anony = false;
File? dummyFille;
String? backgroundimgname = (Random().nextInt(99) + 1).toString();
Set<int> imagenumber = {int.parse(backgroundimgname!)};

class _WriteState extends State<Write> {
  setimagenumber() {
    while (imagenumber.length < 10) {
      imagenumber.add(Random().nextInt(99) + 1);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      style = style.copyWith(
          color: Colors.white,
          fontSize: 15.sp,
          fontWeight: FontWeight.w800,
          fontFamily: 'Nanum Gothic',
          background: Paint()..color=Colors.black
      );
      fontText = "나눔";
      colors = false;
      weight = false;
      textsize = 15;
      taglist=[];
      taglistname = [];
      contextcontroller = TextEditingController();
      forme = false;
      usinglocation = false;
      dummyFille = null;
      backgroundimgname = (Random().nextInt(99) + 1).toString();
      if (backgroundimgname != null) {
        backimg = Image.network('$urls/api/pic/default/${backgroundimgname!}');
        imagenumber = {int.parse(backgroundimgname!)};
      }
    });
    getlocation();
    permissionquest();
    setimagenumber();
  }

  Image backimg = Image.network('$urls/api/pic/default/1');
  TextStyle buttontext = GoogleFonts.gowunBatang(fontSize: 12.sp);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: Basic(
        widgets: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  SolarIconsOutline.doubleAltArrowLeft,
                  size: 30.r,
                )),
            Text(
              "새로운 글",
              style: GoogleFonts.nanumGothic(
                  fontSize: 25.sp, fontWeight: FontWeight.w600),
            ),
            const PostButton()
          ]),
        ),
        SizedBox(height: 10.h),
        Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              MiddleTextField(
                backimg: backimg,
              ),
            ])),
        BottomBar(
            formefun: formefun,
            usinglocationfun: usinglocationfun,
            Showbackgroundimgnamefun: showbackgroundimgnamefun,
            annoyfun: annoyfun,
            forme: forme,
            usinglocation: usinglocation,
            anony: anony)
      ],
        )));
  }

  resetting() {
    setState(() {
      backimg = backimg;
    });
    Navigator.pop(context);
  }

  pickdefaultimg(int e) {
    //기본이미지
    setState(() {
      backgroundimgname = e.toString();
      if (backgroundimgname != null) {
        backimg = Image.network('$urls/api/pic/default/${backgroundimgname!}');
      }
    });
  }

  dummyFillefun() async {
    //사용자이미지
    XFile? f = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (f != null) dummyFille = File(f.path);
    String lengths = dummyFille.toString();
    lengths = lengths.substring(lengths.length - 4, lengths.length - 1);
    if (dummyFille!.lengthSync() / (1024 * 1024) > 3) {
      Fluttertoast.showToast(msg: "이미지의 크기가 3MB 미만이어야 합니다.");
    } else {
      setState(() {
        backgroundimgname = null;
        backimg = Image.file(dummyFille!);
      });
    }
    // print(dummyFille);
  }

  formefun() {
    setState(() {
      forme = !forme;
    });
  }

  usinglocationfun() {
    setState(() {
      usinglocation = !usinglocation;
    });
  }

  annoyfun() {
    setState(() {
      anony = !anony;
    });
  }

  showbackgroundimgnamefun() {
    imagenumber.clear();
    if (backgroundimgname != null) {
      imagenumber.add(int.parse(backgroundimgname!));
    }
    while (imagenumber.length < 10) {
      imagenumber.add(Random().nextInt(99) + 1);
    }
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
              height: 200.h,
              color: Colors.white70,
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            imagenumber.clear();
                            if (backgroundimgname != null) {
                              imagenumber.add(int.parse(backgroundimgname!));
                            }
                            while (imagenumber.length < 10) {
                              imagenumber.add(Random().nextInt(99) + 1);
                            }
                          });
                        },
                        child: const Text(
                          "도란배경",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                        width: 1.w,
                        height: 20.h,
                        color: Colors.black,
                      ),
                      TextButton(
                          onPressed: () {
                            dummyFillefun();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "내 사진",
                            style: TextStyle(color: Colors.black),
                          ))
                    ]),
                Wrap(
                  children: imagenumber
                      .map((e) => TextButton(
                            onPressed: () {
                              dummyFille = null;
                              Navigator.pop(context);
                              pickdefaultimg(e);
                            },
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            child: Image.network(
                              '$urls/api/pic/default/$e',
                              width: 72.w,
                              height: 72.h,
                              fit: BoxFit.cover,
                              opacity: e.toString() == backgroundimgname
                                  ? const AlwaysStoppedAnimation<double>(0.3)
                                  : const AlwaysStoppedAnimation<double>(1),
                            ),
                          ))
                      .toList(),
                )
              ]));
        });
      },
    );
  }
}
