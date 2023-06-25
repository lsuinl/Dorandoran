import 'dart:io';
import 'dart:math';
import 'package:dorandoran/common/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/css.dart';
import 'package:dorandoran/common/uri.dart';
import 'package:dorandoran/texting/write/component/write_top.dart';
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
bool anony=false;
File? dummyFille;
List<String> hashtag = [];
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
    setState(() {
      contextcontroller = TextEditingController();
      forme = false;
      usinglocation = false;
      hashtag = [];
      dummyFille = null;
      backgroundimgname = (Random().nextInt(99) + 1).toString();
      if (backgroundimgname != null) {
        backimg = Image.network('$urls/api/background/' + backgroundimgname!);
        imagenumber = {int.parse(backgroundimgname!)};
      }
    });
    getlocation();
    permissionquest();
    setimagenumber();
  }

  Image backimg = Image.network('$urls/api/background/' + '1');
  TextStyle buttontext = GoogleFonts.gowunBatang(fontSize: 12.sp);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          decoration: gradient,
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("글 작성하기", style: GoogleFonts.gowunBatang(fontSize: 35.sp),),
                          Top(),
                        ]),
                    SizedBox(height: 70.h),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(children: [
                              MiddleTextField(
                                  backimg: backimg,
                                  widgets: Wrap(
                                      children: hashtag != [] ? hashtag.map((e) => Chip(label: Text(e))).toList() : [Text("")])),
                            ]),
                            Row(
                              //하단메뉴
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          forme = !forme;
                                        });
                                      },
                                      icon: forme ? Icon(Icons.lock, size: 25.r,) : Icon(Icons.lock_open, size: 25.r)),
                                  Text("나만보기", style: buttontext)
                                ]),
                                Column(children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          usinglocation = !usinglocation;
                                        });
                                        print(usinglocation);
                                      },
                                      icon: usinglocation
                                          ? Icon(Icons.location_on, size: 25.r)
                                          : Icon(Icons.location_off_outlined, size: 25.r)),
                                  Text("위치정보", style: buttontext,)
                                ]),
                                Column(children: [
                                  IconButton(
                                      onPressed: () => GetImageFile(),
                                      icon: Icon(Icons.image, size: 25.r)),
                                  Text("갤러리", style: buttontext,)
                                ]),
                                Column(children: [
                                  IconButton(
                                    icon: Icon(Icons.grid_view, size: 25.r),
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          imagenumber.clear();
                                          if (backgroundimgname != null)
                                            imagenumber.add(int.parse(backgroundimgname!));
                                          while (imagenumber.length < 10)
                                            imagenumber.add(Random().nextInt(99) + 1);
                                          return StatefulBuilder(builder:
                                              (context, StateSetter setState) {
                                            return Container(
                                              height: 200.h,
                                              color: Colors.white70,
                                              child: Column(
                                                children: <Widget>[
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              imagenumber.clear();
                                                              if (backgroundimgname != null) {
                                                                imagenumber.add(
                                                                    int.parse(backgroundimgname!));
                                                              }
                                                              while (imagenumber.length < 10)
                                                                imagenumber.add(Random().nextInt(99) + 1);
                                                            });
                                                          },
                                                          icon: Icon(
                                                              Icons.restart_alt,
                                                              size: 25.r)),
                                                      Wrap(
                                                        children: imagenumber.map((e) => TextButton(
                                                                child: Image.network(
                                                                  '$urls/api/background/' + e.toString(),
                                                                  width: 72.w,
                                                                  height: 72.h,
                                                                  fit: BoxFit.cover,
                                                                  opacity: e.toString() == backgroundimgname
                                                                      ? AlwaysStoppedAnimation<double>(0.3) : AlwaysStoppedAnimation<double>(1),
                                                                ),
                                                                onPressed: () => pickdefaultimg(e),
                                                                style: ButtonStyle(
                                                                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                        },
                                      );
                                    },
                                  ),
                                  Text("감성배경", style: buttontext,)
                                ]),
                                Column(children: [
                                  IconButton(
                                    //태그
                                    icon: Icon(Icons.tag, size: 25.r),
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                          isDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            TextEditingController tagcontroller = TextEditingController();
                                            return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                              return Container(
                                                  height: 200.h,
                                                  color: Colors.transparent,
                                                  child: Container(
                                                      decoration: const BoxDecoration(
                                                        color: Color(0xBBFFFFFF),
                                                        borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(30),
                                                          topRight: Radius.circular(30),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: <Widget>[
                                                            Container(
                                                              width: 300.w,
                                                              child: TextFormField(
                                                                textInputAction: TextInputAction.go,
                                                                onFieldSubmitted: (value) {
                                                                  setState(() {
                                                                    tagcontroller.clear();
                                                                    hashtag.add(value);
                                                                  });
                                                                  print(hashtag);
                                                                },
                                                                style: GoogleFonts.gowunBatang(fontSize: 20.sp),
                                                                decoration: InputDecoration(
                                                                  hintText: "태그명을 입력해주세요",
                                                                  hintStyle: whitestyle.copyWith(
                                                                      fontSize: 15.sp,
                                                                      color: Colors.black12),
                                                                ),
                                                                controller: tagcontroller,
                                                              ),
                                                            ),
                                                            Wrap(
                                                              children: hashtag == null ? [Text('')] :
                                                              hashtag.map((e) => Chip(
                                                                            label: Text(e),
                                                                            onDeleted: () {
                                                                              setState(() {
                                                                                hashtag.removeAt(hashtag.indexOf(e));
                                                                              });
                                                                              hashtag.remove(e);
                                                                            },
                                                              )).toList(),
                                                            ),
                                                            ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                      //모서리를 둥글게
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      side: BorderSide(color: Colors.white, width: 1)),
                                                                  primary: Colors.lightBlueAccent,
                                                                  minimumSize: Size(70, 40)),
                                                              child: const Text('완료'),
                                                              onPressed: resetting,
                                                            )
                                                          ],
                                                        ),
                                                      )));
                                            });
                                          });
                                    },
                                  ),
                                  Text("해시태그", style: buttontext,)
                                ]),
                                Column(children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          anony=!anony;
                                        });
                                      },
                                      icon: anony ? Icon(Icons.person, size: 25.r,) : Icon(Icons.person_off, size: 25.r)),
                                  Text("익명", style: buttontext)
                                ]),
                              ],
                            ),
                          ]),
                    ),
                  ],
                )),
          )),
    );
  }

  resetting() {
    setState(() {
      backimg = backimg;
    });
    Navigator.pop(context);
  }

  pickdefaultimg(int e) {
    //기본이미지
    dummyFille = null;
    Navigator.pop(context);
    setState(() {
      backgroundimgname = e.toString();
      if (backgroundimgname != null)
        backimg = Image.network('$urls/api/background/' + backgroundimgname!);
    });
  }

  GetImageFile() async {
    //사용자이미지
    XFile? f = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (f != null)
      dummyFille = File(f.path);
    print(dummyFille);
    setState(() {
      backgroundimgname = null;
      backimg = Image.file(dummyFille!);
    });
  }
}
