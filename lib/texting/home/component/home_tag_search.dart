import 'package:dorandoran/texting/home/model/search_hash.dart';
import 'package:flutter/material.dart';
import '../quest/get_search_hash.dart';

// 검색을 위해 앱의 상태를 변경해야하므로 StatefulWidget 상속
class TagSearch extends StatefulWidget {
  const TagSearch({Key? key}) : super(key: key);

  @override
  TagSearchState createState() => TagSearchState();
}

class TagSearchState extends State<TagSearch> {
  TextEditingController searchTextController = TextEditingController();
  List<Widget> searchresult=[];
  bool showlist = false;
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            TextFormField(
              controller: searchTextController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    icon: (Icon(Icons.search)),
                    suffixIcon: IconButton(
                      onPressed: (){searchTextController.clear();},
                        icon:Icon(Icons.cancel)),
                    hintText: "관심 태그를 추가해보세요",),
              onTap: (){
                //검색결과나오는 창 만들기
                print("눌림");
                setState(() {
                  showlist=true;
                });
              },
              onEditingComplete: (){
                setState(() {
                  showlist=false;
                });
              },
              onChanged: (text) async {
                //검색결과창의 데이터 계속해서 변경하기
                List<searchHash> list = await GetSearchHash(text);
                print(list.map((e) => e.hashTagName));
                setState(() {
                  searchresult = list.map((e) => Column(
                    children: [
                      Text(e.hashTagName),
                      Text("게시글 수: ${e.hashTagCount}"),
                      e.hashTagCheck==true ? IconButton(onPressed: (){}, icon: Icon(Icons.add)): IconButton(onPressed: (){}, icon: Icon(Icons.cancel))
                    ],)
                  ).toList();
                });

              },
            ),
          ],
        );
  }

  }

