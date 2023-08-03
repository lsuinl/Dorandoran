import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dorandoran/common/util.dart';
import '../../../texting/post_datail/post_detail.dart';

class MyListCard extends StatefulWidget {
  final String time;
  final String message;
  final String backimg;
  final int postId;
  final String font;
  final String fontColor;
  final int? fontSize;
  final int fontBold;

  const MyListCard(
      {required this.postId,
        required this.time,
        required this.message,
        required this.backimg,
        required this.font,
        required this.fontColor,
        required this.fontSize,
        required this.fontBold,
        Key? key})
      : super(key: key);

  @override
  State<MyListCard> createState() => _MyListCardState();
}

class _MyListCardState extends State<MyListCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      elevation: 2, //그림자
      child: InkWell(
        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetail(postId:widget.postId))),
        child: Container(
          decoration: BoxDecoration(
             // borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(
                image: NetworkImage('http://' + widget.backimg),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.dstATop),
              )),
          //BoxDecoration(image: DecorationImage(image:Network1Image('http://'+backimg))),
          child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 100.h,
                    child: Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(widget.message,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: selectfont(widget.font, widget.fontColor,
                                widget.fontSize??14, widget.fontBold)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time_filled_rounded),
                          SizedBox(width: 3.w),
                          Text(timecount(widget.time)),
                          SizedBox(width: 7.w),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              )),
        ),
      ),
    );
  }
}