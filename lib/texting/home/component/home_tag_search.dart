import 'package:dorandoran/texting/home/model/search_hash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../quest/get_search_hash.dart';

// 검색을 위해 앱의 상태를 변경해야하므로 StatefulWidget 상속
class TagSearch extends StatefulWidget {

  const TagSearch({Key? key}) : super(key: key);

  @override
  TagSearchState createState() => TagSearchState();
}

class TagSearchState extends State<TagSearch> {
  TextEditingController searchTextController = TextEditingController();
  FocusNode focusnode = FocusNode();
  List<Widget> searchresult=[];
  bool showlist = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            TextFormField(
              controller: searchTextController,
                focusNode: focusnode,
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
                          Text("#${e.hashTagName}"),
                          Row(
                            children: [
                              Text("게시글 수: ${e.hashTagCount} "),
                              e.hashTagCheck == false
                                  ? IconButton(
                                  onPressed: () {
                                    print("눌림");
                                  }, icon: Icon(Icons.add))
                                  : IconButton(
                                  onPressed: () {}, icon: Icon(Icons.cancel))
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
        );
  }
  }

