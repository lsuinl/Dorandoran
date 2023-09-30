import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../quest/delete_del_my_hash.dart';
import '../quest/post_add_my_hash.dart';

class HashButton extends StatefulWidget {
  final String tagnames;
  final bool mytags;

  const HashButton({
    required this.tagnames,
    required this.mytags,
    super.key});

  @override
  State<HashButton> createState() => _HashButtonState();
}
bool mytag=false;

class _HashButtonState extends State<HashButton> {
  @override
  void initState() {
    mytag=widget.mytags;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   IconButton(onPressed: (){
      if(mytag==false)
        addMyHash(widget.tagnames);
      else
        delMyHash(widget.tagnames);
      setState(() {
        mytag=!mytag;
      });
    }, icon: Icon(mytag ?Icons.star: Icons.star_outline_sharp,size: 30.r,color: Colors.yellow,));
  }
}
