import 'package:dorandoran/texting/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dorandoran/common/util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solar_icons/solar_icons.dart';
import '../../post_datail/model/postcard_detaril.dart';
import '../../post_datail/post_detail.dart';
import '../../post_datail/quest/post/post_postdetail_post_detail.dart';

class Message_Card extends StatefulWidget {
  final String time;
  final int heart;
  final int? chat;
  final int? map;
  final String message;
  final String backimg;
  final int postId;
  final String font;
  final String fontColor;
  final int? fontSize;
  final int fontBold;

  const Message_Card(
      {required this.postId,
      required this.time,
      required this.heart,
      required this.chat,
      required this.map,
      required this.message,
      required this.backimg,
      required this.font,
      required this.fontColor,
      required this.fontSize,
      required this.fontBold,
      Key? key})
      : super(key: key);

  @override
  State<Message_Card> createState() => _Message_CardState();
}

Map<int, int> click = {0: 0};
class _Message_CardState extends State<Message_Card> {
  @override
  void initState() {
    super.initState();
    setState(() {
      click.addAll({widget.postId: widget.heart});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      elevation: 0, //그림자
      child: InkWell(
        onTap: () async {
          postcardDetail e =  await PostPostDetail(widget.postId,"");
          if(e==404){
            Fluttertoast.showToast(msg: "이미 삭제된 글입니다.");
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          }
          else
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => PostDetail(postId: widget.postId,e:e)));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              image: DecorationImage(
                image: NetworkImage('https://${widget.backimg}'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.overlay),
              )),
          child: Column(
                children: [
                  SizedBox(
                    height: 140.h,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      alignment: Alignment.center,
                        child: Text(widget.message,
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: selectfonttoHome(widget.font, widget.fontColor,
                                widget.fontSize??14, widget.fontBold)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xBB3E3E3E),
                    child:Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time_filled,color: Colors.white),
                          SizedBox(width: 3.w),
                          Text(timecount(widget.time),style:TextStyle(color: Colors.white,)),
                          SizedBox(width: 7.w),
                          if (widget.map != null) const Icon(SolarIconsBold.mapPoint,color: Colors.white),
                          Text(widget.map == null ? '' : '${widget.map}km',style:TextStyle(color: Colors.white,)),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(SolarIconsBold.heart,color: Colors.white),
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                          SizedBox(width: 3.w),
                          Text('${click[widget.postId]}',style:TextStyle(color: Colors.white,)),
                          SizedBox(width: 7.w),
                          const Icon(SolarIconsBold.dialog2,color: Colors.white),
                          SizedBox(width: 3.w),
                          Text('${widget.chat}',style:TextStyle(color: Colors.white,)),
                        ],
                      ),
                    ],
                  )
                  )
                  )
                ],
              )),
        ),
    );
  }
}