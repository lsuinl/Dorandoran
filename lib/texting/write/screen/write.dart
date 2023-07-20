import 'dart:io';
import 'dart:math';
import 'package:dorandoran/common/util.dart';
import 'package:dorandoran/texting/write/component/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dorandoran/common/uri.dart';
import 'package:dorandoran/texting/write/component/post_button.dart';
import '../../../common/basic.dart';
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
    return Basic(
      widgets: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Text("글 작성하기", style: GoogleFonts.gowunBatang(fontSize: 35.sp),),
                PostButton()
                  ]
              ),
              SizedBox(height: 70.h),
          Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    MiddleTextField(
                        backimg: backimg,
                        hashtag: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: hashtag.map((e) => Chip(label: Text(e))).toList()),
                              SizedBox(width: 360.w)
                            ])
                        )
                    ),
                    ])),
              BottomBar(
                  formefun: formefun,
                  usinglocationfun: usinglocationfun,
                  dummyFillefun: dummyFillefun,
                  Showbackgroundimgnamefun: Showbackgroundimgnamefun,
                  ShowHashTagfun: ShowHashTagfun,
                  annoyfun: annoyfun,
                  forme: forme,
                  usinglocation: usinglocation,
                  anony: anony)
            ],
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
    setState(() {
      backgroundimgname = e.toString();
      if (backgroundimgname != null)
        backimg = Image.network('$urls/api/background/' + backgroundimgname!);
    });
  }

  dummyFillefun() async {
    //사용자이미지
    XFile? f = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (f != null) dummyFille = File(f.path);
    print(dummyFille);
    setState(() {
      backgroundimgname = null;
      backimg = Image.file(dummyFille!);
    });
  }

  formefun(){
    setState(() {
      forme = !forme;
    });
  }

  usinglocationfun(){
    setState(() {
      usinglocation = !usinglocation;
    });
  }

  annoyfun(){
    setState(() {
      anony = !anony;
    });
  }
  ShowHashTagfun() {
    showModalBottomSheet<void>(
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          TextEditingController tagcontroller =
          TextEditingController();
          return StatefulBuilder(builder:
              (BuildContext context,
              StateSetter setState) {
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
                              onFieldSubmitted:
                                  (value) {
                                setState(() {
                                  tagcontroller.clear();
                                  hashtag.add(value);
                                });
                                print(hashtag);
                              },
                              style: GoogleFonts.gowunBatang(fontSize: 20.sp),
                              decoration: InputDecoration(
                                hintText: "태그명을 입력해주세요",
                                hintStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                    fontSize: 15.sp, color: Colors.black12),
                              ),
                              controller: tagcontroller,
                            ),
                          ),
                          Wrap(
                            children: hashtag == null
                                ? [Text('')]
                                : hashtag.map((e) =>
                                Chip(
                                  label: Text(e),
                                  onDeleted: () {
                                    setState(() {
                                      hashtag.removeAt(hashtag.indexOf(e));
                                    });
                                    hashtag.remove(e);
                                  },)).toList(),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: Colors.white,
                                        width: 1)),
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
  }

  Showbackgroundimgnamefun() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        imagenumber.clear();
        if (backgroundimgname != null)
          imagenumber.add(int.parse(backgroundimgname!));
        while (imagenumber.length < 10)
          imagenumber.add(Random().nextInt(99) + 1);

        return StatefulBuilder(builder:
            (BuildContext context,
            StateSetter setState) {
          return Container(
            height: 200.h,
            color: Colors.white70,
            child: Column(
          children:[
                      IconButton(
                          onPressed: () {
                            setState(() {
                              imagenumber.clear();
                              if (backgroundimgname != null) {
                                imagenumber.add(int.parse(backgroundimgname!));
                              }
                              while (imagenumber.length < 10)
                                imagenumber.add(Random().nextInt(99) + 1);
                            });
                          },
                          icon: Icon(Icons.restart_alt, size: 25.r)),
            Wrap(
              children: imagenumber.map((e) => TextButton(
                            child: Image.network('$urls/api/background/' + e.toString(),
                              width: 72.w,
                              height: 72.h,
                              fit: BoxFit.cover,
                              opacity: e.toString() == backgroundimgname
                                  ? AlwaysStoppedAnimation<double>(0.3)
                                  : AlwaysStoppedAnimation<double>(1),
                            ),
                            onPressed:(){
                              dummyFille = null;
                              Navigator.pop(context);
                              pickdefaultimg(e);
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                          )).toList(),
                        )
          ])
          );
        });
      },
    );
  }
}
