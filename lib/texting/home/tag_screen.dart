import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:dorandoran/texting/hash_detail/hash_detail.dart';
import 'package:dorandoran/texting/home/model/popular_hash.dart';
import 'package:dorandoran/texting/home/model/postcard.dart';
import 'package:dorandoran/texting/home/quest/delete_del_my_hash.dart';
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
CustomPopupMenuController tagcontroller = CustomPopupMenuController();
class _TagScreenState extends State<TagScreen> {
  List<popularHash> populartagname = [];
  List<String> mytag = [];
  List<Widget> mycontent = [];
  @override
  void initState() {
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
            mycontent = snapshot.data!;
            return GestureDetector(
                onTap: () {
                  if (showlist == true) {
                    setState(() {
                      showlist = false;
                    });
                  }
                },
                child:
                ListView(children: [
                  Column(children: [
                    Stack(
                        children: [
                          Column(
                            children: [ SizedBox(height: 50.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("인기 태그",
                                      style: GoogleFonts.abel(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: populartagname
                                      .map((e) =>
                                      TextButton(
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => HashDetail(tagnames: e.hashTagName)));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    10),
                                                image: DecorationImage(
                                                    image: Image
                                                        .network(
                                                        '$urls/api/pic/default/' +
                                                            (e.hashTagName
                                                                .codeUnits
                                                                .first % 100)
                                                                .toString())
                                                        .image,
                                                    fit: BoxFit.cover,
                                                    colorFilter: ColorFilter
                                                        .mode(
                                                        Colors.white
                                                            .withOpacity(0.6),
                                                        BlendMode.dstATop)),
                                              ),
                                              child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 13.h,
                                                      horizontal: 20.w),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                          e.hashTagName,
                                                          style: TextStyle(
                                                              fontSize: 20.sp,
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                        Text(
                                                          e.hashTagCount
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 20.sp,
                                                              color: Colors
                                                                  .black),
                                                        )
                                                      ])))
                                          ))
                                      .toList()),
                            ],
                          ),
                          TagSearch(statemanager: statemanager)
                        ]),
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
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: [Row(
                              mainAxisSize: MainAxisSize.max,
                              children: mytag
                                  .map((e) =>
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 5.h, bottom: 5.h, right: 10.w),
                                      child: GestureDetector(
                                          onLongPressStart: (details) async {
                                            final offset = details
                                                .globalPosition;
                                            showMenu(
                                                context: context,
                                                position: RelativeRect.fromLTRB(
                                                  offset.dx,
                                                  offset.dy,
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width - offset.dx,
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height - offset.dy,
                                                ),
                                                items: [
                                                  PopupMenuItem(
                                                    child: TextButton(
                                                      child: Text("삭제",
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            color: Colors
                                                                .black),),
                                                      onPressed: () {
                                                        delMyHash(e);
                                                        statemanager();
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                ]);
                                          },
                                          child: InputChip(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HashDetail(
                                                              tagnames: e
                                                                  .toString())));
                                            },
                                            label: Text(e),
                                          ))))
                                  .toList(),
                            ),
                              SizedBox(width: 360.w,)
                            ]
                        )
                    ),
                    SizedBox(height: 10.h),
                    mycontent != null
                        ? Column(children: mycontent)
                        : Container(),
                    SizedBox(height: 10.h),
                  ])
                ]));
        }
    );
  }
  Future<List<Widget>> getdata() async {
  print("dd..");
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
    List<Widget> mycontentwidget = await mycontents
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
      populartagname = populartagnames;
      mytag = mytags;
     return widgets;
  }

  Widget sizemenu(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 220,
        color: const Color(0xFF4C4C4C),
        child: GridView.count(
            padding:
            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            crossAxisCount: 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children:[TextButton(
                onPressed: () {
                  setState(() {
                  });
                },
                child:Text("d")
            )]
        ),
      ),
    );
  }
  statemanager(){
    print("실행됨");
    setState(() {
      mycontent=[];
      populartagname = [];
      mytag = [];
      getdata();
    });
  }

}
