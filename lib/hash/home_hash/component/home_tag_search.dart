import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../search/search_screen.dart';


class TagSearch extends StatefulWidget {
  final VoidCallback statemanager;

  const TagSearch({
    required this.statemanager,
    Key? key}) : super(key: key);

  @override
  TagSearchState createState() => TagSearchState();
}

bool showlist = false;

class TagSearchState extends State<TagSearch> {
  TextEditingController searchTextController = TextEditingController();
  List<Widget> searchresult = [];
  Map<String, int>? mytagcheck;
  FocusNode textFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:
      Column(
          children: [
      Padding(
        padding: EdgeInsets.only(top: 25,left: 15,right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
      Container(
          width: 330.w,
          height: 40.h,
          child:TextFormField(
        controller: searchTextController,
        focusNode: textFocus,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFD9D9D9),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
        prefixIcon: (Icon(SolarIconsOutline.magnifier)),
       ),
      onTap: widget.statemanager,
      onChanged: (text) async {},
    ))],))
    ]
    ,
    )
    );
  }

}
