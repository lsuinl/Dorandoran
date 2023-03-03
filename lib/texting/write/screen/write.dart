import 'dart:io';
import 'dart:math';
import 'package:dorandoran/common/util.dart';
import 'package:dorandoran/texting/get/screen/loding.dart';
import 'package:dorandoran/texting/write/quest/post.dart';
import 'package:dorandoran/common/storage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/css.dart';
import 'package:dorandoran/common/uri.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Write extends StatefulWidget {
  const Write({Key? key}) : super(key: key);

  @override
  State<Write> createState() => _WriteState();
}

TextEditingController contextcontroller = TextEditingController();
bool forme = false;
bool usinglocation = false;
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
        backimg = Image.network(imgurl + backgroundimgname!);
        imagenumber = {int.parse(backgroundimgname!)};
      }
    });
    getlocation();
    permissionquest();
    setimagenumber();
  }

  Image backimg = Image.network(imgurl + '1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          decoration: gradient,
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "글 작성하기",
                      style: TextStyle(fontSize: 30.sp),
                    ),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Top(),
                            Column(children: [
                              MiddleTextField(backimg: backimg),
                              Wrap(
                                  children: hashtag != []
                                      ? hashtag
                                          .map((e) => Chip(label: Text(e)))
                                          .toList()
                                      : [Text("")])
                            ]),
                            Row(
                              //하단메뉴
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        forme = !forme;
                                      });
                                    },
                                    icon: forme
                                        ? Icon(Icons.lock)
                                        : Icon(Icons.lock_open)),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        usinglocation = !usinglocation;
                                      });
                                      print(usinglocation);
                                    },
                                    icon: usinglocation
                                        ? Icon(Icons.location_on)
                                        : Icon(Icons.location_off_outlined)),
                                IconButton(
                                    onPressed: () {
                                      GetImageFile();
                                    },
                                    icon: Icon(Icons.image)),
                                IconButton(
                                  //기본이미지
                                  icon: Icon(Icons.grid_view),
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        imagenumber.clear();
                                        if (backgroundimgname != null) {
                                          imagenumber.add(
                                              int.parse(backgroundimgname!));
                                        }
                                        while (imagenumber.length < 10) {
                                          imagenumber
                                              .add(Random().nextInt(99) + 1);
                                        }
                                        return StatefulBuilder(
                                            builder: //10개가져오기
                                                (context,
                                                    StateSetter setState) {
                                          return Container(
                                            height: 200.h,
                                            color: Colors.white70,
                                            child: Column(
                                              children: <Widget>[
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          // 이미지 리셋
                                                          setState(() {
                                                            imagenumber.clear();
                                                            if (backgroundimgname !=
                                                                null) {
                                                              imagenumber.add(
                                                                  int.parse(
                                                                      backgroundimgname!));
                                                            }
                                                            while (imagenumber
                                                                    .length <
                                                                10) {
                                                              imagenumber.add(
                                                                  Random().nextInt(
                                                                          99) +
                                                                      1);
                                                            }
                                                          });
                                                        },
                                                        icon: Icon(
                                                            Icons.restart_alt)),
                                                    Wrap(
                                                      children: imagenumber
                                                          .map(
                                                            (e) => TextButton(
                                                              child:
                                                                  Image.network(
                                                                imgurl +
                                                                    e.toString(),
                                                                width: 72.w,
                                                                height: 72.h,
                                                                fit: BoxFit
                                                                    .cover,
                                                                // colorBlendMode: e==backimg ? BlendMode.modulate: BlendMode.clear,
                                                                opacity: e.toString() ==
                                                                        backgroundimgname
                                                                    ? AlwaysStoppedAnimation<
                                                                            double>(
                                                                        0.3)
                                                                    : AlwaysStoppedAnimation<
                                                                        double>(1),
                                                              ),
                                                              onPressed: () =>
                                                                  pickdefaultimg(
                                                                      e),
                                                              style:
                                                                  ButtonStyle(
                                                                padding: MaterialStateProperty
                                                                    .all(EdgeInsets
                                                                        .zero),
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
                                IconButton(
                                  //태그
                                  icon: Icon(Icons.tag),
                                  onPressed: () {
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
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xBBFFFFFF),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(30),
                                                        topRight:
                                                            Radius.circular(30),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 300.w,
                                                            child:
                                                                TextFormField(
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .go,
                                                              onFieldSubmitted:
                                                                  (value) {
                                                                setState(() {
                                                                  tagcontroller
                                                                      .clear();
                                                                  hashtag.add(
                                                                      value);
                                                                });
                                                                print(hashtag);
                                                              },
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      20.sp),
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "태그명을 입력해주세요",
                                                                hintStyle: whitestyle.copyWith(
                                                                    fontSize:
                                                                        15.sp,
                                                                    color: Colors
                                                                        .black12),
                                                              ),
                                                              controller:
                                                                  tagcontroller,
                                                            ),
                                                          ),
                                                          Wrap(
                                                            children: hashtag ==
                                                                    null
                                                                ? [Text('')]
                                                                : hashtag
                                                                    .map((e) =>
                                                                        Chip(
                                                                          label:
                                                                              Text(e),
                                                                          onDeleted:
                                                                              () {
                                                                            setState(() {
                                                                              hashtag.removeAt(hashtag.indexOf(e));
                                                                            });
                                                                            hashtag.remove(e);
                                                                          },
                                                                        ))
                                                                    .toList(),
                                                          ),
                                                          ElevatedButton(
                                                            child: const Text(
                                                                '완료'),
                                                            onPressed:
                                                                resetting,
                                                          )
                                                        ],
                                                      ),
                                                    )));
                                          });
                                        });
                                  },
                                )
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
      if (backgroundimgname != null) {
        backimg = Image.network(imgurl + backgroundimgname!);
      }
    });
  }

  GetImageFile() async {
    //사용자이미지
    XFile? f = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (f != null) {
      dummyFille = File(f.path);
    }
    print(dummyFille);
    setState(() {
      backgroundimgname = null;
      backimg = Image.file(dummyFille!);
    });
  }
}

class Top extends StatelessWidget {
  //완료(글보내기)
  const Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topRight,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.black),
            onPressed: () async {
              String? locations;
              MultipartFile? userimage;
              if (usinglocation) {
                locations = '${latitude},${longtitude}';
              } else {
                locations = "";
              }
              if (dummyFille != null) {
                userimage = await MultipartFile.fromFile(dummyFille!.path,
                    filename: dummyFille!.path.split('/').last);
              } else {
                userimage = null;
              }
              if (contextcontroller.text != '') {
                writing(
                  //useremail!,
                  '4@gmail.com',
                  contextcontroller.text,
                  forme,
                  locations,
                  backgroundimgname,
                  hashtag == [] ? null : hashtag,
                  userimage,
                );
                print(
                    "useremail:${useremail}\ncontext:${contextcontroller.text}\nforme:${forme}\nLocation: ${locations}\nbackimg:${backgroundimgname}\nhashtag${hashtag}\n filename:${dummyFille}");
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    //애니매이션제거
                    pageBuilder: (BuildContext context,
                        Animation<double> animation1,
                        Animation<double> animation2) {
                      return loding();
                    },
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              }
            },
            child: Text("완료")));
  }
}

class MiddleTextField extends StatefulWidget {
  final Image backimg;

  const MiddleTextField({required this.backimg, Key? key}) : super(key: key);

  @override
  State<MiddleTextField> createState() => _MiddleTextFieldState();
}

List<int> menuitem = [10, 12, 18, 24, 28, 36, 48];
List<String> menufontitem = [
  'cuteFont',
  'nanumGothic',
  'nanumMyeongjo',
  'dongle',
  'Jua',
  'sunflower'
];

TextStyle style = TextStyle();

class _MiddleTextFieldState extends State<MiddleTextField> {
  @override
  Widget build(BuildContext context) {
    void changeColor(Color color) {
      setState(() {
        style = style.copyWith(color: color);
      });
    }

    return Column(children: [
      Container(
        height: 300.h,
        decoration: BoxDecoration(
          border: Border.all(),
          image: DecorationImage(
              image: widget.backimg.image,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.dstATop)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            style: style,
            maxLines: null,
            expands: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              hintText: "내용을 작성해주세요",
              hintStyle: whitestyle.copyWith(color: Colors.black12),
            ),
            controller: contextcontroller,
          ),
        ),
      ),
      Row(
        children: [
          //폰트종류
          DropdownButton2(
            customButton: const Icon(
              Icons.font_download,
              size: 40,
            ),
            dropdownDecoration: BoxDecoration(color: Colors.white),
            dropdownWidth: 150,
            dropdownDirection: DropdownDirection.left,
            items: [
              ...menufontitem.map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text('$item'),
                  onTap: () {
                    setState(() {
                      [
                        'cuteFont',
                        'nanumGothic',
                        'nanumMyeongjo',
                        'dongle',
                        'Jua',
                        'sunflower'
                      ];
                      if (item == 'cuteFont')
                        style =
                            GoogleFonts.getFont('Cute Font', textStyle: style);
                      else if (item == 'nanumGothic')
                        style = GoogleFonts.getFont('Nanum Gothic',
                            textStyle: style);
                      else if (item == 'nanumMyeongjo')
                        style = GoogleFonts.getFont('Nanum Myeongjo',
                            textStyle: style);
                      else if (item == 'dongle')
                        style = GoogleFonts.getFont('Dongle', textStyle: style);
                      else if (item == 'Jua')
                        style = GoogleFonts.getFont('Jua', textStyle: style);
                      else if (item == 'sunflower')
                        style =
                            GoogleFonts.getFont('Sunflower', textStyle: style);
                    });
                  },
                ),
              ),
            ],
            onChanged: (value) {},
          ),
          IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      Color pickerColor = style.color!;

                      void chancolor(Color color) {
                        setState(() => pickerColor = color);
                      }

                      return Column(
                        children: [
                          ColorPicker(
                            pickerColor: pickerColor,
                            onColorChanged: chancolor,
                            pickerAreaHeightPercent: 0.9,
                            enableAlpha: true,
                            paletteType: PaletteType.hsvWithHue,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                changeColor(pickerColor);
                                Navigator.pop(context);
                              },
                              child: Text("확인"))
                        ],
                      );
                    });
              },
              icon: Icon(Icons.palette)), //색상
          DropdownButton2(
            customButton: const Icon(
              Icons.format_size,
              size: 40,
            ),
            dropdownDecoration: BoxDecoration(color: Colors.white),
            dropdownWidth: 150,
            dropdownDirection: DropdownDirection.left,
            items: [
              ...menuitem.map(
                (item) => DropdownMenuItem<int>(
                  value: item,
                  child: Text('$item'),
                  onTap: () {
                    setState(() {
                      style = style.copyWith(fontSize: item.sp);
                      print('dd');
                    });
                  },
                ),
              ),
            ],
            onChanged: (value) {},
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  if (style.fontWeight == FontWeight.w900) {
                    style = style.copyWith(fontWeight: FontWeight.w400);
                  } else {
                    style = style.copyWith(fontWeight: FontWeight.w900);
                  }
                });
              },
              icon: Icon(Icons.title)), //굵기굵게얇게
        ],
      ),
    ]);
  }
}
