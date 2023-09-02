import 'package:flutter/material.dart';
import '../../search/search_screen.dart';


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
  FocusNode textFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    child:
      Column(
          children: [
            Padding(padding: EdgeInsets.all(20),
            child:
            TextFormField(
              controller: searchTextController,
                focusNode: textFocus,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  prefixIcon: (Icon(Icons.search)),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          showlist=false;
                        });
                        },
                        icon:Icon(Icons.cancel)),
                    hintText: "관심 태그를 추가해보세요",),
              onTap: () {
                searchTextController.removeListener(() { });
               textFocus.unfocus();
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                },
              onChanged: (text) async {
              },
            )),
          ],
        ));
  }

}
