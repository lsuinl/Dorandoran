import 'package:dorandoran/write/component/font_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solar_icons/solar_icons.dart';
import '../screen/write.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

class MiddleTextField extends StatefulWidget {
  final Image backimg;

  const MiddleTextField({required this.backimg, Key? key}) : super(key: key);

  @override
  State<MiddleTextField> createState() => _MiddleTextFieldState();
}

TextStyle style = TextStyle(
    color: Colors.black,
    fontSize: 15.sp,
    fontWeight: FontWeight.w800,
    fontFamily: 'Nanum Gothic'); //기본폰트

String fontText = "나눔";
//폰트 속성 변경 변수
List<String> menufontitem = [
  'cuteFont',
  'nanumGothic',
  'Jua',
];
bool colors = false, weight = false;
int textsize = 15;
late List<Widget> taglist; //ui용
List<String> taglistname = []; //데이터전송용
CustomPopupMenuController sizeController = CustomPopupMenuController();
CustomPopupMenuController fontController = CustomPopupMenuController();
TextEditingController tagcontroller = TextEditingController();

class _MiddleTextFieldState extends State<MiddleTextField> {
  @override
  void initState() {
    taglist = [
      Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Icon(SolarIconsBold.hashtagCircle, size: 24.r)),
      TextButton(
          style: TextButton.styleFrom(
              minimumSize: const Size(60, 10),
              backgroundColor: const Color(0xBB2D2D2D),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0),)),
          onPressed: onTagPressed,
          child: const Text("+", style: TextStyle(color: Colors.white),))
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(//메세지 입력칸
          height: 400.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
                image: widget.backimg.image,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop)),
          ),
          child: Stack(
            children: [
              TextFormField(
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.center,
                controller: contextcontroller,
                style: style,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                  hintText: "내용을 작성해주세요",
                  hintStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.black12),
                ),
              ),
              Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: taglist))))
            ],
          )),
      Padding( //글씨관련메뉴
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: FontButton(
            font:onfont,
              color: onColor,
              size: onSize,
              weight: onWeight
          )
      ),
    ]);
  }

  onColor(){
    setState(() {
      if (style.color == Colors.black) {
        colors = true;
        style = style.copyWith(color: Colors.white);
      } else {
        colors = false;
        style = style.copyWith(color: Colors.black);
      }
    });
  }
  onSize(){
    setState(() {
      if (style.fontSize == 45) {
        style = style.copyWith(fontSize: 15);
        textsize = 15;
      } else {
        style = style.copyWith(fontSize: 45);
        textsize = 45;
      }
    });
  }

  onWeight(){
    setState(() {
      if (style.fontWeight == FontWeight.w900) {
        style = style.copyWith(fontWeight: FontWeight.w400);
        weight = false;
      } else {
        style = style.copyWith(fontWeight: FontWeight.w900);
        weight = true;
      }
    });
  }

  onfont(){
    setState(() {
    });
  }
  onTagPressed(){
    tagcontroller.clear();
    taglist.insert(
        taglist.length - 1,
        Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xBB2D2D2D),
              ),
              width: 70.w,
              height: 25.h,
              child: TextField(
                autofocus: true,
                controller: tagcontroller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder:
                  UnderlineInputBorder(borderSide: BorderSide.none),
                ),
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                textAlignVertical: TextAlignVertical.top,
                textAlign: TextAlign.center,
                onTapOutside: (value) {
                  if (tagcontroller.text == "") {
                    setState(() {
                      taglist.removeAt(taglist.length - 2);
                    });
                  } else {
                    if (taglistname.contains(tagcontroller.text)) {
                      Fluttertoast.showToast(msg: "같은 태그를 여러 번 사용할 수 없습니다.");
                    }
                    else {
                      setState(() {
                        taglistname.add(tagcontroller.text);
                        taglist[taglist.length - 2] = Padding(
                            padding: const EdgeInsets.only(right: 5),
                            key: Key(tagcontroller.text),
                            child: Chip(
                              backgroundColor: const Color(0xBB2D2D2D),
                              label: Text(
                                tagcontroller.text,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onDeleted: () {
                                setState(() {
                                  taglist.removeWhere((element) =>
                                  element.key ==
                                      Key(tagcontroller.text));
                                  taglistname.remove(tagcontroller.text);
                                });
                              },
                            ));
                      });
                    }
                  }
                },
                onSubmitted: (value) {
                  if (value == "") {
                    setState(() {
                      taglist.removeAt(taglist.length - 2);
                    });
                  } else {
                    setState(() {
                      taglistname.add(value.toString());
                      taglist[taglist.length - 2] = Padding(
                          padding: const EdgeInsets.only(right: 5),
                          key: Key(value.toString()),
                          child: Chip(
                            backgroundColor: const Color(0xBB2D2D2D),
                            label: Text(
                              value.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            onDeleted: () {
                              setState(() {
                                taglist.removeWhere((element) =>
                                element.key ==
                                    Key(value.toString()));
                                taglistname.remove(value.toString());
                              });
                            },
                          ));
                    });
                  }
                },
              ),
            )));
    setState(() {});
  }
}
