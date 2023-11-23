import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icons/solar_icons.dart';

import '../../common/basic.dart';
import '../hash_detail/hash_detail.dart';
import 'model/popular_hash.dart';
import 'quest/get_popular_hash.dart';
import 'quest/get_search_hash.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback statemanage;
  const SearchScreen({
    required this.statemanage,
    Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

List<Widget> schoollist = [];

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController school = TextEditingController();
  List<popularHash> populartagname = [];

  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Basic(
        widgets:
        Padding(
        padding:EdgeInsets.all(15),
        child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Flexible(child:
              Container(
                  height: 40.h,
                  child: TextFormField(
                    controller: school,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).brightness==Brightness.dark?Colors.grey:Color(0xFFD9D9D9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: (Icon(SolarIconsOutline.magnifier)),
                    ),
                    style: Theme.of(context).textTheme.bodyLarge,
                    keyboardType: TextInputType.text,
                    onChanged: (text) async {
                      if(text!="") {
                        List list = await GetSearchHash(text);
                        print(list.map((e) => e.hashTagName));
                        setState(() {
                          schoollist = list
                              .map((e) =>
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child:
                          Padding(
                              padding: EdgeInsets.all(10),
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e.hashTagName,style: Theme.of(context).textTheme.headlineMedium,),
                                  Container(),
                                  Text(" 게시글: ${e.hashTagCount}",style: Theme.of(context).textTheme.bodyLarge),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HashDetail(tagnames: e.hashTagName)));
                                      },
                                      icon: Icon(SolarIconsOutline.doubleAltArrowRight,size: 20.r,))
                                ],
                              ))))
                              .toList();
                        });
                      }
                    },
                  ))),
              Container(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                    onPressed: widget.statemanage,
                    child: Text(
                      "취소",
                      style:Theme.of(context).textTheme.headlineMedium!,
                    )),
              )
            ],
          )),
      school.text == ""
          ?
          //인기태그목록
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text("인기태그"),
                Wrap(
                  crossAxisAlignment:WrapCrossAlignment.start,
                    children:
                        List<Widget>.generate(populartagname.length, (int idx) {
                  return Padding(padding: EdgeInsets.symmetric(horizontal: 3),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HashDetail(tagnames: populartagname[idx].hashTagName)));
                    },
                    child:
                    Chip(
                    label: Text(populartagname[idx].hashTagName),
                  )));
                }))
              ],
            )
          : Container(),
          school.text==""?
              Container(
                width: MediaQuery.of(context).size.width,
            child:Column(
                  children:[
                    SizedBox(height: 80.h),
                  Icon(SolarIconsOutline.magnifier),
                    SizedBox(height: 10.h),
                    Text("관심있는 태그를 검색해 보세요")
  ]
                )):Container(),
              school.text!=""?  Flexible(child: ListView(children: schoollist)):Container()
    ])));
  }

  void get() async {
    List<popularHash> populartagnames = await GetPopularHash();
    setState(() {
      populartagname = populartagnames;
    });
  }
}
