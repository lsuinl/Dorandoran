import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:dorandoran/write/component/write_middlefield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FontButton extends StatefulWidget {
  final VoidCallback color;
  final VoidCallback size;
  final VoidCallback weight;
  final VoidCallback font;

  const FontButton({
    required this.color,
    required this.size,
    required this.weight,
    required this.font,
    super.key});

  @override
  State<FontButton> createState() => _FontButtonState();
}

class _FontButtonState extends State<FontButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomPopupMenu( //폰트
          menuBuilder: fontmenu,
          pressType: PressType.singleClick,
          controller: sizeController, //폰트
          child: Text(
              fontText,
              style: Theme.of(context).textTheme.headlineMedium!),
        ),
        const SizedBox(width: 10),
        IconButton(
          //밑줄변경
          icon: Icon(Icons.border_color,
              color: colors == true ? Colors.grey : Colors.black),
          onPressed:widget.color,
        ),
        const SizedBox(width: 10),
        TextButton(//폰트크기
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: widget.size,//폰트크기
            child: Text(
              textsize == 15 ? "작게" : "크게",
              style: Theme.of(context).textTheme.headlineMedium!,
            )),
        const SizedBox(width: 10),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.white),
          onPressed: widget.weight,
          child: Text(weight ? "굵게" : "얇게",
              style: Theme.of(context).textTheme.headlineMedium!),
        ),
      ],
    );
  }

  Widget fontmenu() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 220,
        color: const Color(0xFF4C4C4C),
        child: GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: menufontitem
              .map((item) => TextButton(
            onPressed: () {
                      setState(() {
                        [
                          'cuteFont',
                          'nanumGothic',
                          'gamjaFlower',
                        ];
                        if (item == 'cuteFont') {
                          style = GoogleFonts.getFont('Cute Font',
                              textStyle: style);
                          fontText = "큐트";
                        } else if (item == 'nanumGothic') {
                          style = GoogleFonts.getFont('Nanum Gothic',
                              textStyle: style);
                          fontText = "나눔";
                        } else if (item == 'gamjaFlower') {
                         style = GoogleFonts.getFont('Gamja Flower', textStyle: style);
                          fontText = "감자";
                        }
                        sizeController.hideMenu();
                      });
                      widget.font();
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
                : Text("감자",
                style: GoogleFonts.gamjaFlower(
                    fontSize: 14.sp, color: Colors.white)),
          ))
              .toList(),
        ),
      ),
    );
  }
}
