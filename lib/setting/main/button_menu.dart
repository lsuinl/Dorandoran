import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icons;
  final String text;

  const MenuButton({
    required this.onPressed,
    required this.icons,
    required this.text,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
            fit: FlexFit.tight,
            child: TextButton.icon(
                icon:Icon(icons, color: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black87, size: 24.r),
                onPressed: onPressed,
                label: Text(text,style: Theme.of(context).textTheme.headlineMedium!,),
                style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft)
            )),
        Container(height: 0.2.h,color: Colors.black26),
      ],
    );
  }
}
