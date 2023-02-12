import 'dart:io';
import 'dart:math';
import 'package:dorandoran/common/util.dart';
import 'package:dorandoran/texting/get/screen/home.dart';
import 'package:dorandoran/texting/get/screen/loding.dart';
import 'package:dorandoran/texting/write/quest/post.dart';
import 'package:dorandoran/common/storage.dart';
import 'package:dorandoran/texting/get/quest/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/css.dart';
import 'package:dorandoran/common/uri.dart';

class Write extends StatefulWidget {
  const Write({Key? key}) : super(key: key);

  @override
  State<Write> createState() => _WriteState();
}

TextEditingController contextcontroller = TextEditingController();
bool forme = false;
bool usinglocation = false;
File? dummyFille;
List<String>? hashtag;
String? backgroundimgname=(Random().nextInt(99) + 1).toString();
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
     dummyFille=null;
     hashtag=null;
     backgroundimgname = (Random().nextInt(99) + 1).toString();
     backimg = Image.network(imgurl + backgroundimgname!);
     imagenumber = {int.parse(backgroundimgname!)};
    });
    permissionquest();
    setimagenumber();
  }
  Image backimg = Image.network(imgurl + backgroundimgname!);

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
                            MiddleTextField(backimg: backimg),
                            Row(
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
                                    onPressed: (){
                                      setState(() {
                                        usinglocation = !usinglocation;
                                      });
                                      print(usinglocation);
                                    },

                                    icon: usinglocation ? Icon(Icons.location_on):Icon(Icons.location_off_outlined)
                                ),
                                IconButton(
                                    onPressed: () {
                                      GetImageFile();
                                    },
                                    icon: Icon(Icons.image)),
                                IconButton(
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
                                                          // 이미지 리셋
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
                                                        icon: Icon(
                                                            Icons.restart_alt)),
                                                    Wrap(
                                                      children: imagenumber.map(
                                                            (e) => TextButton(
                                                              child: Image.network(
                                                                imgurl +
                                                                    e.toString(),
                                                                width: 72.w,
                                                                height: 72.h,
                                                                fit: BoxFit
                                                                    .cover,
                                                                    // colorBlendMode: e==backimg ? BlendMode.modulate: BlendMode.clear,
                                                                opacity: e.toString()==backgroundimgname ?  AlwaysStoppedAnimation<double>(0.3):AlwaysStoppedAnimation<double>(1),
                                                              ),
                                                              onPressed: () =>
                                                                  pickdefaultimg(e),
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
                                    onPressed: () {}, icon: Icon(Icons.tag)),
                              ],
                            )
                          ]),
                    ),
                  ],
                )),
          )),
    );
  }

  pickdefaultimg(int e) {
    dummyFille = null;
    Navigator.pop(context);
    setState(() {
      backgroundimgname = e.toString();
      backimg = Image.network(imgurl + backgroundimgname!);
    });
  }

  GetImageFile() async {
    XFile? f = await ImagePicker().pickImage(source: ImageSource.gallery);
    dummyFille = File(f!.path);
    print(dummyFille);
    setState(() {
      backgroundimgname = null;
      backimg = Image.file(dummyFille!);
    });
  }
}

class Top extends StatelessWidget {
  const Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topRight,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.black),
            onPressed: () async{
              String? locations;
              if(usinglocation){
                locations='${latitude},${longtitude}';
              }
              else{
                locations=null;
              }
              if (contextcontroller.text != null) {
                print('되었어요');
                writing(
                  '404@gmail.com',
                  contextcontroller.text,
                  forme,
                  locations,
                  backgroundimgname,
                  null,
                  dummyFille,
                );
                print(
                    "useremail:${useremail}\ncontext:${contextcontroller.text}\nforme:${forme}\nLocation: ${locations}\nbackimg:${backgroundimgname}\nhashtag${hashtag}\n filename:${dummyFille}");
              }
              Navigator.push(
                context,
                PageRouteBuilder( //애니매이션제거
                  pageBuilder: (BuildContext context, Animation<double> animation1,
                      Animation<double> animation2) {
                    return loding();
                  },
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            child: Text("완료")));
  }
}

class MiddleTextField extends StatelessWidget {
  final Image backimg;

  const MiddleTextField({required this.backimg, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      decoration: BoxDecoration(
        border: Border.all(),
        image: DecorationImage(
            image: backimg.image,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop)),
      ),
      child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.sp),
              maxLines:null,
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
    );
  }
}

