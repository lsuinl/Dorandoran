import 'package:flutter/material.dart';

// 검색을 위해 앱의 상태를 변경해야하므로 StatefulWidget 상속
class TagSearch extends StatefulWidget {
  const TagSearch({Key? key}) : super(key: key);

  @override
  TagSearchState createState() => TagSearchState();
}

class TagSearchState extends State<TagSearch> {

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    icon: (Icon(Icons.search)),
                    suffixIcon: Icon(Icons.cancel),
                    hintText: "관심 태그를 추가해보세요",),
              onTap: (){
              },
            ),
          ],
        );
  }
}

