import 'package:dorandoran/texting/post_datail/model/postcard_detaril.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../../common/util.dart';
import '../../../hash/hash_detail/hash_detail.dart';
import '../../home/quest/home_postLike.dart';

class Detail_Card extends StatefulWidget {
  final int postId;
  final postcardDetail card;

  const Detail_Card({required this.postId, required this.card, Key? key})
      : super(key: key);

  @override
  State<Detail_Card> createState() => _Detail_CardState();
}

bool like = false;
int likecnt = 0;

class _Detail_CardState extends State<Detail_Card> {
  @override
  void initState() {
    setState(() {
      like = widget.card.postLikeResult!;
      likecnt = widget.card.postLikeCnt;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('http://' + widget.card.backgroundPicUri),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.dstATop),
              )),
          child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 350.h,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.card.content,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: selectfont(
                                  widget.card.font,
                                  widget.card.fontColor,
                                  widget.card.fontSize,
                                  widget.card.fontBold)),
                          SizedBox(height: 20.h),
                          Text(
                              "by ${widget.card.postAnonymity == false ? widget.card.postNickname : "익명"}",
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: selectfont(
                                      widget.card.font,
                                      widget.card.fontColor,
                                      widget.card.fontSize,
                                      widget.card.fontBold)
                                  .copyWith(fontSize: 12.sp)),
                        ]),
                  ),
                  widget.card.postHashes != null
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            Icon(SolarIconsBold.hashtagCircle,size: 24.r,),
                            Row(
                                children: widget.card.postHashes!
                                    .map((e) =>Padding(
                                    padding: EdgeInsets.only(right: 3),
                                    child:
                                    InputChip(
                                  backgroundColor: Color(0xBB2D2D2D),
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => HashDetail(tagnames: e.toString())));
                                          },
                                          label: Text(e,style: TextStyle(color: Colors.white,fontSize: 12.sp),),
                                        )))
                                    .toList()),
                            SizedBox(
                              width: 360.w,
                            )
                          ]))
                      : Container(),
                 ])),
        ),
      ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child:
          IconButton(
            onPressed: ()async {
              SharedPreferences prefs =await  SharedPreferences.getInstance();
              if(widget.card.postNickname== prefs.getString("nickName")){
                Fluttertoast.showToast(msg:"자신의 글은 좋아요를 누를 수 없습니다.");
              }
              else {
                setState(() {
                  like = !like;
                  if (likecnt != widget.card.postLikeResult &&
                      like == false) {
                    //화면에서 취소누르면,,
                    likecnt = likecnt - 1;
                  } else
                  if (likecnt != widget.card.postLikeResult &&
                      like == true) {
                    //화면에서 좋아요
                    likecnt = widget.card.postLikeCnt + 1;
                  } else {
                    likecnt = widget.card.postLikeCnt;
                  }
                });
                postLike(widget.postId);
              }
            },
            icon: like!
                ? Icon(SolarIconsBold.heart,size: 30.r,)
                : Icon(SolarIconsOutline.heart,size: 30.r,),
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
          )),
              Row(
                children: [
                  Icon(Icons.access_time_filled_rounded),
                  SizedBox(width: 3.w),
                  Text(timecount(widget.card.postTime)),
                  SizedBox(width: 7.w),
                  widget.card.location!=null ? Row(
                    children: [
                      Icon(SolarIconsBold.mapPoint),
                      Text('${widget.card.location}km'),
                    ],
                  ):Container(),
                  SizedBox(width: 7.w),
                ],
              ),
        ],
    )]
      );
  }
}
