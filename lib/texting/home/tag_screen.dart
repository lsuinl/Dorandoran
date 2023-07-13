import 'dart:math';
import 'package:dorandoran/texting/hash_detail/hash_detail.dart';
import 'package:dorandoran/texting/home/model/popular_hash.dart';
import 'package:dorandoran/texting/home/model/postcard.dart';
import 'package:dorandoran/texting/home/quest/get_my_hash.dart';
import 'package:dorandoran/texting/home/quest/get_my_hash_content.dart';
import 'package:dorandoran/texting/home/quest/get_popular_hash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/uri.dart';
import 'component/home_message_card.dart';
import 'component/home_tag_search.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({Key? key}) : super(key: key);

  @override
  State<TagScreen> createState() => _TagScreenState();
}

List<popularHash> populartagname = [];
List<String> mytag = [];
List<Widget> mycontent = [];

class _TagScreenState extends State<TagScreen> {
  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//로딩 futurebuilder 변경필요
    return ListView(children: [
      Column(children: [
        TagSearch(),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("인기 태그",
                style: GoogleFonts.abel(
                    fontSize: 15.sp, fontWeight: FontWeight.w500))
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: populartagname
                .map((e) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: Image.network('$urls/api/background/' +
                                      (Random().nextInt(99) + 1).toString())
                                  .image,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.white.withOpacity(0.6),
                                  BlendMode.dstATop)),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 13.h,horizontal: 20.w),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.hashTagName,
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.black),
                                  ),
                                  Text(
                                    e.hashTagCount.toString(),
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.black),
                                  )
                                ])))))
                .toList()),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: 1.h,
            color: Colors.grey,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("나의 태그",
                style: GoogleFonts.abel(
                    fontSize: 15.sp, fontWeight: FontWeight.w500))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: mytag
              .map((e) => Padding(
                  padding: EdgeInsets.only(top: 5.h,bottom: 5.h, right: 10.w),
                  child: InputChip(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HashDetail(tagnames: e.toString())));
                    },
                    label: Text(e),
                  )))
              .toList(),
        ),
        SizedBox(height: 10.h),
        mycontent != null ? Column(children: mycontent) : Container(),
        SizedBox(height: 10.h),
      ])
    ]);
  }

  void getdata() async {
    List<popularHash> populartagnames = await GetPopularHash();
    List<String> mytags = await GetMyHash();
    List<postcard> mycontents = await GetMyHashContent();
    List<Widget> mytagswidget = mytag
        .map((e) =>
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("# $e",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HashDetail(tagnames: e.toString())));
                  },
                  icon: Icon(Icons.add))
            ]))
        .toList();
    List<Widget> mycontentwidget = mycontents
        .map<Message_Card>((e) => Message_Card(
              time: e.postTime,
              heart: e.likeCnt,
              chat: e.replyCnt,
              map: e.location,
              message: e.contents,
              backimg: e.backgroundPicUri,
              postId: e.postId,
              likeresult: e.likeResult,
              font: e.font,
              fontColor: e.fontColor,
              fontSize: e.fontSize,
              fontBold: e.fontBold,
            ))
        .toList();
    List<Widget> widgets = [];
    for (int i = 0; i < mytagswidget.length; i++) {
      widgets.add(Column(
        children: [mytagswidget[i], mycontentwidget[i]],
      ));
    }
    setState(() {
      populartagname = populartagnames;
      mytag = mytags;
      mycontent = widgets;
    });
  }
}
