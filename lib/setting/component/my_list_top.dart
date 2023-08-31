import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icons/solar_icons.dart';

class MyListTop extends StatelessWidget {
  final String text;

  const MyListTop({
    required this.text,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:Icon(SolarIconsOutline.doubleAltArrowLeft,size: 30.r,)),
        Row(children:[
          Icon(SolarIconsOutline.hashtag,size: 26.r,),
          Text(" $text", style: TextStyle(fontSize: 24.sp)),]),
  Container(width: 50.w,)
  //      IconButton(onPressed: (){}, icon: Icon(Icons.star_outline_sharp,size: 30.r,))
      ],
    );
  }
}
