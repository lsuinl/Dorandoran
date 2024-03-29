import 'package:dorandoran/texting/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dorandoran/common/util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../texting/post_datail/model/postcard_detaril.dart';
import '../../texting/post_datail/post_detail.dart';
import '../../texting/post_datail/quest/post/post_postdetail_post_detail.dart';

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
            onTap: () async {
              postcardDetail e = await PostPostDetail(widget.postId, "");
              if (e == 404) {
                Fluttertoast.showToast(msg: "이미 삭제된 글입니다.");
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              } else
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PostDetail(postId: widget.postId, e: e)));
            },
            child: Container(
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(
                  image: NetworkImage('https://' + widget.backimg),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.overlay),
                )),
                //BoxDecoration(image: DecorationImage(image:Network1Image('http://'+backimg))),
                child: Column(children: [
                      SizedBox(
                        height: 100.h,
                        child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(widget.message,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: selectfonttoHome(
                                    widget.font,
                                    widget.fontColor,
                                    widget.fontSize ?? 14,
                                    widget.fontBold)),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xBB3E3E3E),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.access_time_filled_rounded,
                                        color: Colors.white),
                                    SizedBox(width: 3.w),
                                    Text(timecount(widget.time),
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                    SizedBox(width: 7.w),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                              ]),
                        ),
                      ),
                    ]))));
  }
}
