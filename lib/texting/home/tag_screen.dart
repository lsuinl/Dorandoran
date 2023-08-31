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
import 'package:solar_icons/solar_icons.dart';
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
                    TagSearch(statemanager: statemanager),
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
    List<popularHash> populartagnames = await GetPopularHash();
    List<String> mytags = await GetMyHash();
    List<postcard> mycontents = await GetMyHashContent();
    List<Widget> mytagswidget = mytag
        .map((e) =>
        Container(
          height: 20.h     ,
            child:
        Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(SolarIconsOutline.hashtag,size: 16.r,)),
              Text("$e", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
              Flexible(child:
              Container()),
    Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
    IconButton(
      padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HashDetail(tagnames: e.toString())));
                  },
                  icon: Icon(SolarIconsOutline.doubleAltArrowRight,size: 20.r,))
    )])))
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
