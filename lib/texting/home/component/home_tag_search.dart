import 'package:dorandoran/texting/hash_detail/hash_detail.dart';
import 'package:dorandoran/texting/home/model/search_hash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../quest/delete_del_my_hash.dart';
import '../quest/get_search_hash.dart';
import '../quest/post_add_my_hash.dart';

class TagSearch extends StatefulWidget {
  final VoidCallback statemanager;
  const TagSearch({
    required this.statemanager,
    Key? key}) : super(key: key);

  @override
  TagSearchState createState() => TagSearchState();
}
bool showlist = false;
class TagSearchState extends State<TagSearch> {
  TextEditingController searchTextController = TextEditingController();
  List<Widget> searchresult=[];
  Map<String,int>? mytagcheck;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    child:
      Column(
          children: [
            TextFormField(
              controller: searchTextController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    icon: (Icon(Icons.search)),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          showlist=false;
                        });
                        searchTextController.clear();
                        },
                        icon:Icon(Icons.cancel)),
                    hintText: "관심 태그를 추가해보세요",),
              onTap: () async {
                List<searchHash> list = await GetSearchHash("");
                setState(() {
                  searchresult = list.map((e) =>
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                   Text("#${e.hashTagName}",style: TextStyle(fontSize: 16.sp,color: Colors.black),),
                          Row(
                            children: [
                              Text("게시글 수: ${e.hashTagCount} "),
                              e.hashTagCheck == false
                                  ? IconButton(
                                  onPressed: () {
                                      addMyHash(e.hashTagName);
                                      setState(() {
                                        showlist=false;
                                      });
                                      widget.statemanager();
                                  }, icon: Icon(Icons.add_circle_outline))
                                  : IconButton(
                                  onPressed: () {
                                    delMyHash(e.hashTagName);
                                    setState(() {
                                      showlist=false;
                                    });
                                    widget.statemanager();
                                  }, icon: Icon(Icons.cancel_outlined))
                            ],
                          )
                        ],)
                  ).toList();
                });
                showlist=true;
              },
              onChanged: (text) async {
                //검색결과창의 데이터 계속해서 변경하기
                List<searchHash> list = await GetSearchHash(text);
                print(list.map((e) => e.hashTagName));
                setState(() {
                  searchresult = list.map((e) =>
                      Row(
                    children: [
                      Text(e.hashTagName),
                      Text(" 게시글 수: ${e.hashTagCount}"),
                      e.hashTagCheck==false ? IconButton(onPressed: (){}, icon: Icon(Icons.add)): IconButton(onPressed: (){}, icon: Icon(Icons.cancel))
                    ],)
                  ).toList();
                });
              },
            ),
            showlist==true ?
      Container(
                decoration: BoxDecoration(
                  color:Colors.white70),
                child:
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 20.w),
                child:Column(children:
              searchresult)
              )
            ) :Container()
          ],
        ));
  }
}
