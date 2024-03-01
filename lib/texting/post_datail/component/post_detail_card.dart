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
    double widths = MediaQuery.of(context).size.width;
    double heights = MediaQuery.of(context).size.height;
    return Column(children: [
      InkWell(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage('https://${widget.card.backgroundPicUri}'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.overlay),
          )),
          child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      ]),
                ),
                 widget.card.postHashes!.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          Icon(
                            SolarIconsBold.hashtagCircle,
                            size: widths/15,
                            color: Colors.grey
                          ),
                          Row(
                              children: widget.card.postHashes!
                                  .map((e) => Padding(
                                      padding: EdgeInsets.only(right: widths/60),
                                      child: InputChip(
                                        backgroundColor: Theme.of(context).brightness ==
                                            Brightness.dark
                                            ? Colors.black26: Colors.white70,
                                        onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => HashDetail(tagnames: e.toString()))),
                                        label: Text(e, style: Theme.of(context).textTheme.bodyMedium!,
                                        ),
                                      ))).toList()),
                        ]))
                    : Container(),
                    SizedBox(height: heights/40,)
              ])),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: IconButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  if (widget.card.postNickname == prefs.getString("nickname")) {
                    Fluttertoast.showToast(msg: "자신의 글은 좋아요를 누를 수 없습니다.");
                  } else {
                    setState(() {
                      like = !like;
                      if (likecnt != widget.card.postLikeResult && like == false) {
                        //화면에서 취소누르면,,
                        likecnt = likecnt - 1;
                      } else if (likecnt != widget.card.postLikeResult && like == true) //화면에서 좋아요
                        likecnt = widget.card.postLikeCnt + 1;
                      else
                        likecnt = widget.card.postLikeCnt;
                    });
                    postLike(widget.postId);
                  }
                },
                icon: like? Icon(SolarIconsBold.heart, size: widths/15)
                    : Icon(SolarIconsOutline.heart, size: widths/15),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              )),
          Row(
            children: [
              const Icon(Icons.access_time_filled_rounded),
              SizedBox(width: 3.w),
              Text(timecount(widget.card.postTime)),
              SizedBox(width: 7.w),
              widget.card.location != null
                  ? Row(
                      children: [
                        const Icon(SolarIconsBold.mapPoint),
                        Text('${widget.card.location}km'),
                      ],
                    )
                  : Container(),
              SizedBox(width: 7.w),
            ],
          ),
        ],
      )
    ]);
  }
}
