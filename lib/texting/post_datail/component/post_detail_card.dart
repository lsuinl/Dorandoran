import 'package:dorandoran/texting/post_datail/model/postcard_detaril.dart';
import 'package:dorandoran/texting/post_datail/quest/post_postdetail_post_delete.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/util.dart';
import '../../hash_detail/hash_detail.dart';
import '../../home/home.dart';
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
List<String> _menulist = ['신고하기','차단하기'];

class _Detail_CardState extends State<Detail_Card> {
  @override
  void initState() {
    setState(() {
      like = widget.card.postLikeResult!;
      likecnt = widget.card.postLikeCnt;
      if (widget.card.isWrittenByMember==true)
        _menulist = ['삭제하기'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(
                image: NetworkImage('http://' + widget.card.backgroundPicUri),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.dstATop),
              )),
          //BoxDecoration(image: DecorationImage(image:NetworkImage('http://'+backimg))),
          child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        BackButton(
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()))
                              .then((value) => setState(() {})),
                        ),
                        DropdownButton2(
                          customButton: Icon(Icons.more_vert),
                          dropdownWidth: 150,
                          dropdownDecoration: BoxDecoration(color: Colors.white),
                          dropdownDirection: DropdownDirection.left,
                          items: [
                            ..._menulist.map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                            ),
                          ],
                          onChanged: (value) {
                            if(value=="삭제하기")
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    // 바깥 영역 터치시 닫을지 여부
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        content: const Text("작성한 글을 삭제하시겠습니까?"),
                                        actions: [
                                          TextButton(
                                            child: const Text('확인', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
                                            onPressed: () async {
                                              await PostPostDelete(widget.postId);
                                              Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) => Home())).then((value) => setState(() {}));
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('취소',
                                                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
                                            onPressed: () => Navigator.of(context).pop()
                                          ),
                                        ],
                                      );
                                    });
                            })
                      ]
                  ),
                  SizedBox(
                    height: 450.h,
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: widget.card.postHashes!
                                    .map((e) => InputChip(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => HashDetail(tagnames: e.toString())));
                                          },
                                          label: Text(e),
                                        ))
                                    .toList()),
                            SizedBox(
                              width: 360.w,
                            )
                          ]))
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time_filled_rounded),
                          SizedBox(width: 3.w),
                          Text(timecount(widget.card.postTime)),
                          SizedBox(width: 7.w),
                          if (widget.card.location != null) Icon(Icons.place),
                          Text(widget.card.location == null
                              ? ''
                              : '${widget.card.location}km'),
                        ],
                      ),
                      Row(
                        //하트버튼
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                like = !like;
                                if (likecnt != widget.card.postLikeResult && like == false) {
                                  //화면에서 취소누르면,,
                                  likecnt = likecnt - 1;
                                } else if (likecnt != widget.card.postLikeResult && like == true) {
                                  //화면에서 좋아요
                                  likecnt = widget.card.postLikeCnt + 1;
                                } else {
                                  likecnt = widget.card.postLikeCnt;
                                }
                              });
                              postLike(widget.postId);
                            },
                            icon: like!
                                ? Icon(Icons.favorite)
                                : Icon(Icons.favorite_border),
                            constraints: BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                          SizedBox(width: 3.w),
                          Text('${likecnt}'),
                          SizedBox(width: 7.w),
                          Icon(Icons.forum),
                          SizedBox(width: 3.w),
                          Text('${widget.card.commentCnt}'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              )),
        ),
      ),
    ]);
  }
}
