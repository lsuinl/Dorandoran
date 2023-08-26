import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_icons/solar_icons.dart';
import '../screen/write.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

class MiddleTextField extends StatefulWidget {
  final Image backimg;

  const MiddleTextField(
      {required this.backimg, Key? key})
      : super(key: key);

  @override
  State<MiddleTextField> createState() => _MiddleTextFieldState();
}

TextStyle style = TextStyle(
    color: Colors.black,
    fontSize: 15.sp,
    fontWeight: FontWeight.w800,
    fontFamily: 'Nanum Gothic'); //기본폰트

//폰트 속성 변경 변수
List<String> menufontitem = [
  'cuteFont',
  'nanumGothic',
  'Jua',
];
bool colors = false, weight = false;
int textsize=15;
late List<Widget> taglist;
List<String> taglistname=[];
CustomPopupMenuController sizeController = CustomPopupMenuController();
CustomPopupMenuController fontController = CustomPopupMenuController();

class _MiddleTextFieldState extends State<MiddleTextField> {
  @override
  void initState() {
    taglist = [
      Padding(
          padding: EdgeInsets.only(right: 5),
          child: Icon(
            SolarIconsBold.hashtagCircle,
            size: 24.r,
          )),
      TextButton(
          style: TextButton.styleFrom(
              minimumSize: Size(60, 10),
              backgroundColor: Color(0xBB2D2D2D),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              )),
          onPressed: () {
            taglist.insert(taglist.length-1,
                Padding(padding: EdgeInsets.only(right: 5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xBB2D2D2D),
                  ),
                  width: 70.w,
                  height: 25.h,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                    style: TextStyle(color:Colors.white,fontSize: 14.sp),
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.center,
                    onTapOutside: (value){
                      if(value=="") {
                        print("삭제");
                        setState(() {
                          taglist.removeAt(taglist.length - 2);
                        });
                      }
                      else {
                        print("확정!");
                        setState(() {
                          taglistname.add(value.toString());
                          taglist[taglist.length-2]=
                              Padding(padding: EdgeInsets.only(right: 5),
                                  child:Chip(
                                    key: Key(value.toString()),
                            backgroundColor: Color(0xBB2D2D2D),
                            label: Text(value.toString(),style: TextStyle(color: Colors.white),),
                            onDeleted: () {
                              setState(() {
                                taglist.removeWhere((element) => element.key==Key(value.toString()));
                                taglistname.remove(value.toString());
                              });
                            },));
                        });
                      }
                    },
                    onSubmitted: (value){
                      if(value=="") {
                        print("삭제");
                        setState(() {
                          taglist.remove(value);
                        });
                      }
                      else{
                        print("확정!");
                        setState(() {
                          taglistname.add(value.toString());
                          taglist[taglist.length-2]=
                              Padding(padding: EdgeInsets.only(right: 5),
                                  key: Key(value.toString()),
                                  child:Chip(
                                    backgroundColor: Color(0xBB2D2D2D),
                                    label: Text(value.toString(),style: TextStyle(color: Colors.white),),
                                    onDeleted: () {
                                      setState(() {
                                        taglist.removeWhere((element) => element.key==Key(value.toString()));
                                        taglistname.remove(value.toString());
                                      });
                                    },));
                        });
                      }
                    },
                  ),
                )));
            setState(() {});
          },
          child: Text(
            "+",
            style: TextStyle(color: Colors.white),
          ))
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(taglistname);
    return Column(children: [
      Container(
          //메세지 입력칸
          height: 400.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(
                image: widget.backimg.image,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop)),
          ),
          child: Stack(
            children: [
              TextFormField(
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.center,
                style: style,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  hintText: "내용을 작성해주세요",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.black12),
                ),
                controller: contextcontroller,
              ),
              Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                          child: Row(children:taglist))))
            ],
          )),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomPopupMenu(
                //글씨체 변경
                child: Icon(Icons.format_color_text),
                menuBuilder: fontmenu,
                pressType: PressType.singleClick,
                controller: sizeController,
              ),
              SizedBox(width: 10),
              IconButton(
                //색상변경
                icon: Icon(Icons.border_color_sharp, color: colors==true?Colors.grey: Colors.black),
                onPressed: () {
                  setState(() {
                    if (style.color == Colors.black) {
                      colors = true;
                      style = style.copyWith(color: Colors.white);
                    } else {
                      colors = false;
                      style = style.copyWith(color: Colors.black);
                    }
                  });
                },
              ),
              SizedBox(width: 10),
    TextButton(
    //폰트크기
    child: Text(textsize==15?"작게":"크게",style: TextStyle(color:Colors.black87, fontSize:18.sp,fontWeight: FontWeight.w600),),
    onPressed: () {
    setState(() {
    if (style.fontSize == 45) {
    style = style.copyWith(fontSize: 15);
    textsize = 15;
    } else {
      style = style.copyWith(fontSize: 45);
      textsize = 45;
    }
    });}),
              SizedBox(width: 10),
              IconButton(
                //폰트굵기
                icon: Icon(
                  Icons.format_bold,
                  size: weight ? 25.r : 20.r,
                ),
                onPressed: () {
                  setState(() {
                    if (style.fontWeight == FontWeight.w900) {
                      style = style.copyWith(fontWeight: FontWeight.w400);
                      weight = false;
                    } else {
                      style = style.copyWith(fontWeight: FontWeight.w900);
                      weight = true;
                    }
                  });
                },
              ),
            ],
          )),
    ]);
  }

  Widget fontmenu() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 220,
        color: const Color(0xFF4C4C4C),
        child: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: menufontitem
              .map((item) => TextButton(
                    onPressed: () {
                      setState(() {
                        setState(() {
                          [
                            'cuteFont',
                            'nanumGothic',
                            'Jua',
                          ];
                          if (item == 'cuteFont')
                            style = GoogleFonts.getFont('Cute Font',
                                textStyle: style);
                          else if (item == 'nanumGothic')
                            style = GoogleFonts.getFont('Nanum Gothic',
                                textStyle: style);
                          else if (item == 'Jua')
                            style =
                                GoogleFonts.getFont('Jua', textStyle: style);
                        });
                        sizeController.hideMenu();
                      });
                    },
                    child: item == 'cuteFont'
                        ? Text(
                            "큐트",
                            style: GoogleFonts.cuteFont(
                                fontSize: 20.sp, color: Colors.white),
                          )
                        : item == 'nanumGothic'
                            ? Text("나눔",
                                style: GoogleFonts.nanumGothic(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                ))
                            : Text("주아",
                                style: GoogleFonts.jua(
                                    fontSize: 14.sp, color: Colors.white)),
                  ))
              .toList(),
        ),
      ),
    );
  }

}
