import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/css.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../screen/write.dart';

class MiddleTextField extends StatefulWidget {
  final Image backimg;

  const MiddleTextField({required this.backimg, Key? key}) : super(key: key);

  @override
  State<MiddleTextField> createState() => _MiddleTextFieldState();
}

List<int> menuitem = [15,32,48];
List<String> menufontitem = [
  'cuteFont',
  'nanumGothic',
  'Jua',
];

TextStyle style = TextStyle(color: Colors.black);
bool colors=false, weight=false;
class _MiddleTextFieldState extends State<MiddleTextField> {
  @override
  Widget build(BuildContext context) {

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
                        'Jua',
                      ];
                      if (item == 'cuteFont')
                        style = GoogleFonts.getFont('Cute Font', textStyle: style);
                      else if (item == 'nanumGothic')
                        style = GoogleFonts.getFont('Nanum Gothic', textStyle: style);
                      else if (item == 'Jua')
                        style = GoogleFonts.getFont('Jua', textStyle: style);
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
                if(style.color==Colors.black){
                    colors=true;
                    style=style.copyWith(color: Colors.white);
                }else{
                    colors=false;
                    style=style.copyWith(color: Colors.black);
                }
                });
              },
              icon:Icon(Icons.palette,color: colors? Colors.white:Colors.black)), //색상
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
                    weight=false;
                  } else {
                    style = style.copyWith(fontWeight: FontWeight.w900);
                    weight=true;
                  }
                });
              },
              icon: Icon(Icons.title )), //굵기굵게얇게
        ],
      ),
    ]);
  }
}
