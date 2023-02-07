import 'dart:io';
import 'dart:math';
import 'package:dorandoran/texting/write/quest/post.dart';
import 'package:dorandoran/user/sign_up/quest/permission.dart';
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
File? dummyFille;
List<String>? hashtag;
String backgroundimgname = (Random().nextInt(99) + 1).toString();
String? latitude, longtitude;
Set<int> imagenumber = {int.parse(backgroundimgname)};

class _WriteState extends State<Write> {
  setimagenumber() {
    while (imagenumber.length < 10) {
      imagenumber.add(Random().nextInt(99) + 1);
    }
  }

  @override
  void initState() {
    permissionquest();
    setimagenumber();
  }

  @override
  Widget build(BuildContext context) {
    print("d");
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
                            MiddleTextField(),
                            BottomButton(onpressed: selectbackimg,),
                          ]),
                    ),
                  ],
                )),
          )),
    );
  }
  selectbackimg(){
    didUpdateWidget(widget);
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
            onPressed: () {
              if (contextcontroller.text != null) {
                print('되었어요');
                writing(
                  '404@gmail.com',
                  contextcontroller.text,
                  forme,
                  latitude,
                  longtitude,
                  '2',
                  ['ㅇㄹㄴ', 'ㅇㄹㄴㅇ'],
                  null,
                );
                print(
                    "useremail:${useremail}\ncontext:${contextcontroller.text}\nforme:${forme}\nLocation: ${latitude},${longtitude}\nbackimg:${backgroundimgname}\nhashtag${hashtag}\n filename:${dummyFille}");
              }
            },
            child: Text("완료")));
  }
}

class MiddleTextField extends StatefulWidget {
  const MiddleTextField({Key? key}) : super(key: key);

  @override
  State<MiddleTextField> createState() => _MiddleTextFieldState();
}

class _MiddleTextFieldState extends State<MiddleTextField> {
  @override
  Widget build(BuildContext context) {
        return Container(
          height: 300.h,
          decoration: BoxDecoration(
            border: Border.all(),
            image: DecorationImage(
                image: NetworkImage(
                  imgurl + backgroundimgname,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop)),
          ),
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
                child: TextFormField(
                  style: TextStyle(fontSize: 20.sp),
                  maxLines: 100,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "내용을 작성해주세요",
                    hintStyle: whitestyle.copyWith(color: Colors.black12),
                  ),
                  controller: contextcontroller,
                ),
              ),
            ],
          ),
        );
      }
}


class BottomButton extends StatefulWidget {
  final VoidCallback onpressed;
  const BottomButton({
    required this.onpressed,
    Key? key}) : super(key: key);

  @override
  State<BottomButton> createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                forme = !forme;
              });
              print(forme);
            },
            icon: forme ? Icon(Icons.lock) : Icon(Icons.lock_open)),
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
                    imagenumber
                        .add(int.parse(backgroundimgname));
                  }
                  while (imagenumber.length < 10) {
                    imagenumber.add(Random().nextInt(99) + 1);
                  }
                return StatefulBuilder(
                    builder: (context, StateSetter setState) {
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
                                      imagenumber
                                          .add(int.parse(backgroundimgname));
                                    }
                                    while (imagenumber.length < 10) {
                                      imagenumber.add(Random().nextInt(99) + 1);
                                    }
                                  });
                                },
                                icon: Icon(Icons.restart_alt)),
                            Wrap(
                              children: imagenumber
                                  .map(
                                    (e) => TextButton(
                                      child: Image.network(
                                        imgurl + e.toString(),
                                        width: 72.w,
                                        height: 72.h,
                                        fit: BoxFit.cover,
                                      ),
                                      onPressed: () {
                                          backgroundimgname = e.toString();
                                          dummyFille = null;
                                          Navigator.pop(context);
                                          widget.onpressed;
                                          print("실행됨");
                                      },
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero),
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
        IconButton(onPressed: () {}, icon: Icon(Icons.tag)),
      ],
    );
  }

  GetImageFile() async {
    XFile? f = await ImagePicker().pickImage(source: ImageSource.gallery);
    dummyFille = File(f!.path);
    print(dummyFille);
  }
}
