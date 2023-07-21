import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screen/write.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

class MiddleTextField extends StatefulWidget {
  final Image backimg;
  final Widget hashtag;

  const MiddleTextField(
      {required this.backimg, required this.hashtag, Key? key})
      : super(key: key);

  @override
  State<MiddleTextField> createState() => _MiddleTextFieldState();
}

TextStyle style = TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w800, fontFamily: 'Nanum Gothic'); //기본폰트

//폰트 속성 변경 변수
List<int> menuitem = [15, 32, 48];
List<String> menufontitem = ['cuteFont', 'nanumGothic', 'Jua',];
bool colors = false, weight = false;

CustomPopupMenuController sizeController = CustomPopupMenuController();
CustomPopupMenuController fontController = CustomPopupMenuController();

class _MiddleTextFieldState extends State<MiddleTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container( //메세지 입력칸
        height: 300.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
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
              hintStyle: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Colors.black12),
            ),
            controller: contextcontroller,
          ),
        ),
      ),
      widget.hashtag,
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              CustomPopupMenu( //글씨체 변경
                child: Icon(Icons.format_color_text),
                menuBuilder: fontmenu,
                pressType: PressType.singleClick,
                controller: sizeController,
              ),
              SizedBox(width: 10),
              IconButton( //색상변경
                  icon: Icon(Icons.border_color_sharp, color: Colors.black),
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
              CustomPopupMenu( //글씨크기변경
                child: Icon(Icons.font_download),
                menuBuilder: sizemenu,
                pressType: PressType.singleClick,
                controller: fontController,
              ),
              SizedBox(width: 10),
              IconButton( //폰트굵기
                  icon: Icon(Icons.format_bold,size: weight ? 25.r : 20.r,),
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

  Widget fontmenu(){
   return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 220,
        color: const Color(0xFF4C4C4C),
        child: GridView.count(
          padding:
          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                    style = GoogleFonts.getFont(
                        'Nanum Gothic',
                        textStyle: style);
                  else if (item == 'Jua')
                    style = GoogleFonts.getFont('Jua',
                        textStyle: style);
                });
                sizeController.hideMenu();
              });
            },
            child: item == 'cuteFont'
                ? Text(
              "큐트",
              style: GoogleFonts.cuteFont(
                  fontSize: 20.sp,
                  color: Colors.white),
            )
                : item == 'nanumGothic'
                ? Text("나눔",
                style: GoogleFonts.nanumGothic(
                  fontSize: 13.sp,
                  color: Colors.white,
                ))
                : Text("주아",
                style: GoogleFonts.jua(
                    fontSize: 14.sp,
                    color: Colors.white)),
          ))
              .toList(),
        ),
      ),
    );
  }

  Widget sizemenu(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 220,
        color: const Color(0xFF4C4C4C),
        child: GridView.count(
          padding:
          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: menuitem
              .map((item) => TextButton(
            onPressed: () {
              setState(() {
                style = style.copyWith(fontSize: item.sp);
                fontController.hideMenu();
              });
            },
            child: item == 15
                ? Text(
              "작게",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!,
            )
                : item == 32
                ? Text("중간",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!)
                : Text("크게",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!),
          ))
              .toList(),
        ),
      ),
    );
  }
}
